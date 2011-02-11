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
        s = google_search(whisk.setting, link.link_url)
        if !s.nil? and s > 0
          #if a result is found, add the relationship item 'uses' product unless that relationship already exists
          @item.parents.create(:childable => product, :relation_type => 'uses') unless !@item.parents.where(:childable_id => product.id).blank?
        end

        c = crunchbase(product)
        if !c.nil? and !c.has_key?('error')
          product.sync_crunchbase(c)
        end
      end    
    end
  end


#Whisk Techniques

  #Searches the item's main website to find the query, returns an estimated count
  def google_search(query, sitelink)
    s = Google::Search::Web.new
    s.query = "'#{query}'" + "site:#{sitelink}"
    s.get_response.estimated_count
  end


  def crunchbase(product)
    product_url = product.links.where(:link_type_id => 6).first

    JSON.parse(Net::HTTP.get(URI.parse("http://api.crunchbase.com/v/1/product/#{product_url}.js"))) if product_url
  end
  
  
end
