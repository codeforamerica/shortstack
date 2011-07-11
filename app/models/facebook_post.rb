class FacebookPost
include MongoMapper::Document
  key :entry_id
  key :title
  key :url
  key :summary
  key :published_date
  key :author
  key :link_id, Integer
  key :is_latest, Boolean
  belongs_to :link
end
