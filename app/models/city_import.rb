require 'json'
require 'open-uri'

# Imports Business.gov API http://business.gov/about/features/api/geodata/all-urls.html

class CityImport

  def initialize
    $current_user = User.first
    @linktype = LinkType.where(:name => 'Website').first
    @citytype = OrgType.where(:name => 'City').first
    @countytype = OrgType.where(:name => 'County').first
    @featureid = WhiskType.where(:name => 'Geoname').first
    @countycode = WhiskType.where(:name => 'Census County Codes').first
    @longlat = WhiskType.where(:name => 'LongLat').first
  end

  def grab_data
    state_abbr.each do |state|
    doc = JSON.parse(open('http://api.business.gov/geodata/city_county_links_for_state_of/'+state+'.json').read)
    process_organizations(doc)
    end
  end

  def process_organizations(orgs)
    orgs.each do |org|
      if org["county_name"].nil?
        add_county(org)
      else
        add_city(org)
      end
    end
  end

  def add_city(org)
    city = Organization.create!(:name => org["name"], :org_type =>@citytype ) unless org["name"].nil?
    city.links.create(:link_url => org["url"], :link_type => @linktype) unless org["url"].nil?
    city.whisks.create(:setting=>org["feature_id"], :whisk_type => @featureid) unless org["feature_id"].nil?
    city.whisks.create(:setting=> org['primary_longitude'] + ", " + org['primary_latitude'], :whisk_type => @longlat) unless org["primary_longitude"].nil?
  end

  def add_county(org)
    county = Organization.create!(:name => org["name"], :org_type =>@countytype) unless org["name"].nil?
    county.links.create(:link_url => org["url"], :link_type => @linktype) unless org["url"].nil?
    county.whisks.create(:setting=>org["feature_id"], :whisk_type => @featureid) unless org["feature_id"].nil?
    county.whisks.create(:setting=>org["fips_county_cd"], :whisk_type => @countycode)
    county.whisks.create(:setting=> org['primary_longitude'] + ", " + org['primary_latitude'], :whisk_type => @longlat) unless org["primary_longitude"].nil?
  end

  def state_abbr
    ["AL", "AK", "AS", "AZ", "AR", "CA", "CO", "CT", "DE", "DC", "FM", "FL", "GA", "GU", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MH", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PW", "PA", "PR", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VI", "VA", "WA", "WV", "WI", "WY"]
  end

end
