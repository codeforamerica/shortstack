# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :link do |f|
  f.name "google"
  f.link_url "http://google.com"
  f.link_type_id 1
  f.linkable_type "Person"
  f.linkable_id 1
end
