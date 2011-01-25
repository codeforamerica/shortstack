# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :whisk do |f|
  f.setting "1600"
  f.whisk_type {Factory(:whisk_type)}
  f.whiskable {Factory(:organization)}
end
