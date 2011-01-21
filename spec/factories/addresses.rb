# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :address do |f|
  f.address "1600 Pennsylvania Ave"
  f.city "Washington"
  f.state "DC"
  f.zipcode "20500"
  f.country "USA"
  f.addressable_type "Person"
  f.addressable_id 1
#  f.lat "MyString"
#  f.long "MyString"
end
