Factory.sequence :email do |n|
  "user#{n}@example.com"
end

Factory.define :user do |user|
  user.email                 { FactoryGirl.create :email }
  user.password              { "password" }
  user.password_confirmation { "password" }
  user.profile {Factory(:profile)}
end
