class FacebookPost
include MongoMapper::Document
  key :entry_id
  key :title
  key :url
  key :summary
  key :created_at, Time
  key :author
  key :link_id, Integer
  key :is_latest, Boolean
  belongs_to :link
end
