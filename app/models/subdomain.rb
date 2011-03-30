class Subdomain < ActiveRecord::Base
  has_many :organization_subdomains
  has_many :organizations, :through => :organization_subdomains
  
end
