class WordDay
  include MongoMapper::Document
  key :link_type #should verify to twitter/facebook/rss/so on
  key :time_date, Time
  key :text
