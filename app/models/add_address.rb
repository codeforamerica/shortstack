class AddAddress

  def initialize
    $current_user = User.first
  end  

  def process  
    Organization.all.each do |organization|
      if organization.addresses.blank?
        setting = organization.whisks.where(:whisk_type_id => 4)
        if !setting.blank?
          begin
            longlat = setting.first.setting.split(", ")
            html = Net::HTTP.get(URI.parse('http://maps.googleapis.com/maps/api/geocode/json?latlng='+longlat[1]+','+longlat[0]+'&sensor=false'))
            s = JSON.parse(html)
            if s['status'] != "ZERO_RESULTS"
                f = s['results'][0]['address_components'].detect { |f| f['types'].include?("administrative_area_level_1")}
                if f
                  puts organization.name
                  organization.addresses.new(:state => f["short_name"], :lat => longlat[1], :long => longlat[0]).save
                end
            end
          rescue 
           puts "Failed to work for #{organization.name}"
          end
        end
      end
    end
  end
  
  def change_name
    orgs = Organization.where(:org_type_id => 4) || Organization.where(:org_type_id => 8)
    orgs.each do |organization|
      if !organization.addresses.blank?
          begin
            state = organization.addresses.first.state
            if !organization.name.include?(state)
              organization.update_attributes(:name => organization.name + ", #{state}")
            end
          rescue 
           puts "Failed to work for #{organization.name}"
          end
      end
    end 
  end 

end