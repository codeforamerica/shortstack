# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :address do |f|
  f.address "MyString"
  f.city "MyString"
  f.state "MyString"
  f.zipcode "MyString"
  f.country "MyString"
  f.lat "MyString"
  f.long "MyString"
end
