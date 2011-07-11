class Tweet
include MongoMapper::Document
  key :data
  key :link_id, Integer
  key :is_latest, Boolean
  belongs_to :link
end
