#This class contains various whisk techniques, like searching an organization's page for code

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
    #grab the whisk
    whisk = product.whisks.where(:whisk_type_id => whisktype).first
    #search for the whisk setting on the website
    if !whisk.nil? and !link.nil?
      s = google_search(whisk.setting, link.link_url)
      if !s.nil? and s > 0
        #if a result is found, add the relationship item 'uses' product unless that relationship already exists
        @item.parents.create(:childable => product, :relation_type => 'uses') unless !@item.parents.where(:childable_id => product.id).blank?
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
  
  
  
  
  
end