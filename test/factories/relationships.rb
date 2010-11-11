# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :relationship do |f|
  f.person_id 1
  f.organization_id 1
  f.product_id 1
  f.relation_type "MyString"
end
