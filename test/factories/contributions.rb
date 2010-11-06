# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :contribution do |f|
  f.user_id 1
  f.contributalble_id 1
  f.contributable_type "MyString"
  f.action "MyString"
end
