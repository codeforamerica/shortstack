# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :note do |f|
  f.note "MyText"
  f.note_type_id 1
end
