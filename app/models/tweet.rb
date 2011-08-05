class Tweet
include MongoMapper::Document
  key :data
  key :link_id, Integer
  key :is_latest, Boolean
  key :created_at, Time
  belongs_to :link
end
