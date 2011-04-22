# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :link do |f|
  f.name "google"
  f.link_url "http://google.com"
  f.link_type_id 1
  f.linkable_type "Person"
  f.linkable_id 1
end

Factory.define :facebook, :parent => :link do |f|
  f.name "Facebook"
  f.link_url "http://www.facebook.com/SF"
  f.link_type_id 1
  f.linkable {Factory(:organization)}
end

Factory.define :twitter_link, :parent => :link do |f|
  f.name 'Twitter'
  f.link_url 'http://twitter.com/rockymeza'
  f.link_type {Factory(:twitter_link_type)}
  f.linkable {Factory(:organization)}
end
