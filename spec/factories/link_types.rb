# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :link_type do |f|
  f.name "MyString"
  f.description "MyString"
end

Factory.define :twitter_link_type, :parent => :link_type do |f|
  f.name "Twitter"
  f.description "Twitter"
end
