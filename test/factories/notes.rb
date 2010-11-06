# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :note do |f|
  f.note "MyText"
  f.noteable_id 1
  f.noteable_type "MyString"
  f.note_type_id 1
end
