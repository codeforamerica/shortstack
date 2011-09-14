FactoryGirl.define do
  factory :user do
    email                 { Faker::Internet.email }
    password              { "password" }
    password_confirmation { "password" }
  end

  factory :org_type do
    name "City"
  end

  #  Organizations

  factory :company_type, :parent => :org_type do
    name "Company"
  end

  factory :county_type, :parent => :org_type do
    name "County"
  end

  factory :nonprofit_type, :parent => :org_type do
    name "Nonprofit"
  end

  factory :organization do
    name "Some name"
    org_type {Factory(:org_type)}
  end

  factory :company, :parent => :organization do
    org_type {Factory(:company_type)}
    links {[Factory(:website_link), Factory(:twitter_link), Factory(:blog_link), Factory(:twitter_link)]}
    addresses {[Factory(:address)]}
    contacts {[Factory(:contact)]}
    notes {[Factory(:about_note)] }
  end

  # Products

  factory :product do
    name Faker::Lorem.words(2).join(" ")
    links {[Factory(:website_link), Factory(:twitter_link), Factory(:blog_link), Factory(:twitter_link)]}
    addresses {[Factory(:address)]}
    contacts {[Factory(:contact)]}
    notes {[Factory(:about_note), Factory(:requirement_note), Factory(:permission_note), Factory(:eula_note)] }
    tag_list {Faker::Lorem.words(5).join(", ")}
  end

  # Address

  factory :address do
    address "1600 Pennsylvania Ave"
    city "Washington"
    state "DC"
    zipcode "20500"
    country "USA"
  end

  # contacts

  factory :contact do
    phone "1-415-625-9627"
    email "info@codeforamerica.org"
  end

  #  notes

  factory :note_type do
    name "MyString"
  end

  factory :note do
    note_type_id 1
    name 'title'
    note 'text'
  end

  factory :eula_note, :parent => :note do
    note_type {Factory(:note_type, :name => "end user license agreement")}
  end

  factory :requirement_note, :parent => :note do
    note_type {Factory(:note_type, :name => "requirements")}
  end

  factory :permission_note, :parent => :note do
    note_type {Factory(:note_type, :name => "distribution permissions")}
  end

  factory :about_note, :parent => :note do
    note_type_id {Factory(:note_type, :name => "about")}
    name 'title'
    note 'text'
  end

  #  relationships

  factory :relationship do
    person_id 1
    organization_id 1
    product_id 1
    relation_type "MyString"
  end

  factory :relation_type do
    name "MyString"
    type_name "MyString"
  end

  # Stats

  factory :statistic do
    statisticable {Factory(:organization)}
    statistic_type {Factory(:statistic_type)}
    value 1
  end

  factory :statistic_type do
    name 1
    description "MyString"
  end

  factory :compete_stat, :parent => :statistic do
    statisticable {Factory(:organization)}
    statistic_type {Factory(:compete_type)}
    value 88000
  end

  factory :compete_type, :parent => :statistic_type do
    name "Compete"
    description 'Compete Statistic'
  end

  # Links

  factory :link_type do
    name "MyString"
    description "MyString"
  end

  factory :link do
    name "google"
    link_url {Faker::Internet.domain_name}
    link_type Factory(:link_type)
  end

  factory :website_link, :parent => :link do
    name 'Website'
    link_type Factory(:link_type, :name => "website")
  end

  factory :blog_link, :parent => :link do
    name 'Website'
    link_type Factory(:link_type, :name => "blog")
  end

  factory :facebook_link, :parent => :link do
    name 'Website'
    link_url "http://www.facebook.com/SF"
    link_type Factory(:link_type, :name => "blog")
  end

  factory :facebook, :parent => :link do
    name "Facebook"
    link_url "http://www.facebook.com/SF"
  end

  factory :twitter_link, :parent => :link do
    name 'Twitter'
    link_url 'http://twitter.com/rockymeza'
  end

  factory :twitter_link_type, :parent => :link_type do
    name "Twitter"
    description "Twitter"
  end

  # FaceBook

  factory :facebook_summary do
      organization {Factory(:facebook)}
      link {Factory(:facebook)}
      facebook_id 1
      name "MyString"
      category "MyString"
      likes 1
  end

  factory :facebook_stat do
    link {Factory(:facebook)}
    facebook_id "1"
    name "Something"
    category "something"
    likes "1"
  end

  # Whisks

  factory :whisk_type do
    name "MyString"
    setting "MyString"
  end

  factory :whisk do
    setting "1600"
    whisk_type {Factory(:whisk_type)}
    whiskable {Factory(:organization)}
  end

  #  Contributions

  factory :contribution do
    user_id 1
    action "MyString"
  end

end
