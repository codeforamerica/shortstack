# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :facebook_summary do |f|
    f.organization {Factory(:facebook)}
    f.link {Factory(:facebook)}
    f.facebook_id 1
    f.name "MyString"
    f.category "MyString"
    f.likes 1
end