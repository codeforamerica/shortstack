# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :facebook_stat do |f|
  f.link {Factory(:facebook)}
  f.facebook_id "1"
  f.name "Something"
  f.category "something"
  f.likes "1"
end