class OrganizationSubdomain < ActiveRecord::Base
  belongs_to :organization
  belongs_to :subdomain
end
