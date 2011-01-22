# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :contact do |f|
  f.phone "1-415-625-9627"
  f.email "info@codeforamerica.org"
  f.twitter "codeforamerica"
  f.facebook "codeforamerica"
  f.linkedin ""
  f.contactable_type "Person"
  f.contactable_id 1
end
