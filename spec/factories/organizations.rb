# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :organization do |f|
  f.name "Dans Organization"
  f.org_type {Factory(:org_type)}
end
