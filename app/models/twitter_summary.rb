class TwitterSummary < ActiveRecord::Base
  belongs_to :organization
  belongs_to :link
  
end
