Factory.define :user do |user|
  user.email                 { Faker::Internet.email }
  user.password              { "password" }
  user.password_confirmation { "password" }
end


#  Organizations

Factory.define :org_type do |o|
  o.name "City"
end

Factory.define :company_type, :parent => :org_type do |c|
  c.name "Company"
end

Factory.define :county_type, :parent => :org_type do |c|
  c.name "County"
end

Factory.define :nonprofit_type, :parent => :org_type do |c|
  c.name "Nonprofit"
end

Factory.define :organization do |o|
  o.name "Some name"
  o.org_type {Factory(:org_type)}
end

Factory.define :company, :parent => :organization do |c|
  c.org_type {Factory(:company_type)}
  c.links {[Factory(:website_link), Factory(:twitter_link), Factory(:blog_link), Factory(:twitter_link)]}
  c.addresses {[Factory(:address)]}
  c.contacts {[Factory(:contact)]}
  c.notes {[Factory(:about_note)] } 
end

# Products

Factory.define :product do |p|
  p.name Faker::Lorem.words(2).join(" ")
  p.links {[Factory(:website_link), Factory(:twitter_link), Factory(:blog_link), Factory(:twitter_link)]}
  p.addresses {[Factory(:address)]}
  p.contacts {[Factory(:contact)]}
  p.notes {[Factory(:about_note), Factory(:requirement_note), Factory(:permission_note), Factory(:eula_note)] } 
  p.tag_list {Faker::Lorem.words(5).join(", ")}
end

# Address

Factory.define :address do |f|
  f.address "1600 Pennsylvania Ave"
  f.city "Washington"
  f.state "DC"
  f.zipcode "20500"
  f.country "USA"
end

# contacts

Factory.define :contact do |f|
  f.phone "1-415-625-9627"
  f.email "info@codeforamerica.org"
end

#  notes

Factory.define :note_type do |f|
  f.name "MyString"
end

Factory.define :note do |f|
  f.note_type_id 1
  f.name 'title'
  f.note 'text'
end

Factory.define :eula_note, :parent => :note do |n|
  n.note_type {Factory(:note_type, :name => "end user license agreement")}
end

Factory.define :requirement_note, :parent => :note do |n|
  n.note_type {Factory(:note_type, :name => "requirements")}
end

Factory.define :permission_note, :parent => :note do |n|
  n.note_type {Factory(:note_type, :name => "distribution permissions")}
end


Factory.define :about_note, :parent => :note do |f|
  f.note_type_id {Factory(:note_type, :name => "about")}
  f.name 'title'
  f.note 'text'
end


#  relationships

Factory.define :relationship do |f|
  f.person_id 1
  f.organization_id 1
  f.product_id 1
  f.relation_type "MyString"
end

Factory.define :relation_type do |f|
  f.name "MyString"
  f.type_name "MyString"
end

# Stats

Factory.define :statistic do |f|
  f.statisticable {Factory(:organization)}
  f.statistic_type {Factory(:statistic_type)}
  f.value 1
end

Factory.define :statistic_type do |f|
  f.name 1
  f.description "MyString"
end

Factory.define :compete_stat, :parent => :statistic do |f|
  f.statisticable {Factory(:organization)}
  f.statistic_type {Factory(:compete_type)}
  f.value 88000
end

Factory.define :compete_type, :parent => :statistic_type do |f|
  f.name "Compete"
  f.description 'Compete Statistic'
end

# Links

Factory.define :link_type do |f|
  f.name "MyString"
  f.description "MyString"
end

Factory.define :link do |f|
  f.name "google"
  f.link_url {Faker::Internet.domain_name}
  f.link_type Factory(:link_type)
end

Factory.define :website_link, :parent => :link do |f|
  f.name 'Website'
  f.link_type Factory(:link_type, :name => "website")
end

Factory.define :blog_link, :parent => :link do |f|
  f.name 'Website'
  f.link_type Factory(:link_type, :name => "blog")
end

Factory.define :facebook_link, :parent => :link do |f|
  f.name 'Website'
  f.link_url "http://www.facebook.com/SF"
  f.link_type Factory(:link_type, :name => "blog")
end


Factory.define :facebook, :parent => :link do |f|
  f.name "Facebook"
  f.link_url "http://www.facebook.com/SF"
end

Factory.define :twitter_link, :parent => :link do |f|
  f.name 'Twitter'
  f.link_url 'http://twitter.com/rockymeza'
end

Factory.define :twitter_link_type, :parent => :link_type do |f|
  f.name "Twitter"
  f.description "Twitter"
end

# FaceBook 

Factory.define :facebook_summary do |f|
    f.organization {Factory(:facebook)}
    f.link {Factory(:facebook)}
    f.facebook_id 1
    f.name "MyString"
    f.category "MyString"
    f.likes 1
end

Factory.define :facebook_stat do |f|
  f.link {Factory(:facebook)}
  f.facebook_id "1"
  f.name "Something"
  f.category "something"
  f.likes "1"
end

# Whisks

Factory.define :whisk_type do |f|
  f.name "MyString"
  f.setting "MyString"
end

Factory.define :whisk do |f|
  f.setting "1600"
  f.whisk_type {Factory(:whisk_type)}
  f.whiskable {Factory(:organization)}
end

#  Contributions

Factory.define :contribution do |f|
  f.user_id 1
  f.action "MyString"
end
