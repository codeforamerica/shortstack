# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :link do |f|
  f.name "MyString"
  f.url "MyText"
  f.linkable_id 1
  f.linkable_type "MyString"
  f.link_type_id 1
end
