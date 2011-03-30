#This class contains various whisk techniques, like searching an organization's page for code
require 'uri'
require 'net/http'

class WhiskBatter

  # Initialize with the object to be whisked, i.e. an organization, person or product
  def initialize(item)
    $current_user = User.first
    @item = item
  end

  def check_for_product(product)
    #grab our types
    linktype = LinkType.where(:name => "Website").first
    whisktype = WhiskType.where(:name => "google search").first
    usetype = RelationType.where(:name => "uses").first
    #get the url for the item
    link = @item.links.where(:link_type_id => linktype).first
    #grab the whisks
    whisk = product.whisks.where(:whisk_type_id => whisktype)
    #loop through search whisks for the whisk setting on the website
    whisk.each do |whisk|
      if !link.nil?
        s = google_search("'#{whisk.setting}'", link.link_url)
        if !s.nil? and s.estimated_count > 0
          #if a result is found, add the relationship item 'uses' product unless that relationship already exists
          @item.parents.create(:childable => product, :relation_type => 'uses') unless !@item.parents.where(:childable_id => product.id).blank?
        end
      end
    end
  end

  def crunch_sync(product)
    c = crunchbase(@item.link_url)
    if !c.nil? and !c.has_key?('error')
      sync_crunchbase(product, c)
      product.save
    end
  end

  #loops through a domains current subdomains
  #and use them to help search google to find new subdomains
  #once the search is complete, it adds another delayed job, unless it returns nil
  def get_all_subdomains
    #grab all the current subdomains, do a search in google
    subdomains = @item.subdomains.map {|x| "-" + x.name}.join(" ")
    f = get_sub_domains(subdomains)
    #add another delayed job, unless it returns nil.
    WhiskBatter.new(@item).send_later(:get_all_subdomains, f) unless f.nil?  
  end


#Whisk Techniques

  #does a google search for domain names, excludes subdomains if specified
  def get_sub_domains(exclude_subdomains="")
    #strip the link of current subdomains
    link = @item.links.where(:link_type_id => 3)
    if !link.blank?
    current_link = get_domain(link.first.link_url)
    #do a google search for link
    s = google_search(exclude_subdomains, current_link)
    #create an array of links from google search, group by url
    if s.estimated_count > 0  
    f = s.map { |x| "http://" + x.visible_uri }.uniq  
    #strip each link to its subdomain
    subdomains = []
      f.each do |url|
        subdomains << get_subdomain(url)
      end
    end
    end
    if subdomains and subdomains != [""]
    #add them to the subdomains list if they don't already exist
    #add them to the city if they don't already exist
      subdomains.each do |subdomain|
        if subdomain != ""
          sub = Subdomain.find_or_create_by_name(subdomain)
          OrganizationSubdomain.find_or_create_by_subdomain_id_and_organization_id(sub.id, @item.id)
        end
      end
      return true
    else
      return nil
    end
  end
  
  def get_subdomain(link)
    url = Domainatrix.parse(link)
    return url.subdomain
  end

  def get_domain(link)
    url = Domainatrix.parse(link)
    return url.domain + '.' + url.public_suffix
  end

  #Searches the item's main website to find the query, returns an estimated count
  def google_search(query, sitelink)
    s = Google::Search::Web.new
    s.query = "#{query}" + " site:#{sitelink}"
    s.get_response
  end


  def crunchbase(item_url)
    item_url.sub!(/^(?:http:\/\/)?(?:www\.)?crunchbase\.com\/(.+)$/, 'http://api.crunchbase.com/v/1/\1.js')
    puts "crunchbase: #{item_url}"
    JSON.parse(Net::HTTP.get(URI.parse(item_url)))
  end

  def sync_crunchbase(product, c)
    # contacts
    contact = {
      :phone => c['phone_number'],
      :email => c['email_address'],
      :twitter => c['twitter_username'],
    }
    product.contacts.build(contact) if not_nil(contact) && product.contacts.where(contact).count == 0

    # addresses
    if c['offices']
      for o in c['offices']
        address = {
          :address => c['address1'],
          :city => c['city'],
          :state => c['state'],
          :zipcode => c['zip_code'],
          :country => c['country_code'],
          :lat => c['latitude'],
          :long => c['longitude'],
        }

        product.addresses.build(address) if not_nil(address) && product.addresses.where(:address => address['address']).count == 0
      end
    end

    # links
    l = [
      {:link_url => c['homepage_url'], :link_type_id => 3, :name => 'Homepage'},
      {:link_url => c['blog_url'], :link_type_id => 1, :name => 'Blog'},
    ]
    for link in l
      product.links.build(link) if not_nil(link) && product.links.where(:link_type_id => link[:link_type_id]).count == 0
    end
    # notes
    if c['overview']
      note = product.notes.where(:note_type_id => 5).first || product.notes.build(:note_type_id => 5)
      note.name = "Crunchbase"
      note.note = c['overview']
    end
  end

  def not_nil(hash)
    hash.select { |k, v|
      !v.nil?
    }.size > 0
  end

end
