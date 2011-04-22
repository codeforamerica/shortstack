# Read about factories at http://github.com/thoughtbot/factory_girl

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