class FacebookSummary < ActiveRecord::Base
  belongs_to :link
  belongs_to :organization
  
  validates_presence_of :link_id, :organization_id
end
  