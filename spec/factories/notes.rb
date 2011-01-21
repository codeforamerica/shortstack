# Read about factories at httpf.//github.com/thoughtbot/factory_girl

Factory.define :note do |f|
  f.note_type_id 1
  f.name 'title'
  f.noteable_type 'Person'
  f.noteable_id '1'
  f.note 'text'
end
