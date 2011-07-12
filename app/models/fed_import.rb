require 'csv'
class FedImport
  
  def create_links
    linktype = LinkType.where(:name => "Website").first
    parse_csv.each do |link_item|
      org = Organization.where(:name => link_item[1]).first
      org.links.create(:link_url => link_item[0], :name => link_item[0], :link_type_id => linktype.id)
    end
  end
  
  def create_orgs
    orgtype = OrgType.where(:name => "Federal Agency").first
    agencies.each do |agency|
      Organization.create(:name => agency, :org_type_id => orgtype.id)
    end
  end
  
  def agencies
    parse_csv.map { |x| x[1]}.uniq
  end
  
  def parse_csv
    CSV.read("public/Federal_Executive_Branch_Internet_Domains.csv")
  end
  
end