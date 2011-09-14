require 'factory_girl'
require 'faker'
require 'factory_girl_rails'
require 'uuid'
require 'open-uri'

puts "adding types"
#Organization Relation Types as Parents
%w(funds owns sponsors services).each do |org|
  RelationType.find_or_create_by_name(:name => org, :type_name => 'Organization', :parent => true)
end

#Organization Relation Types as Children
%w(uses).each do |org|
  RelationType.find_or_create_by_name(:name => org, :type_name => 'Organization')
end

#Person Relation Types as Parents
%w(funds codes board services owns).each do |person|
  RelationType.find_or_create_by_name(:name => person, :type_name => 'Person', :parent => true)
end

#Person Relation Types as Child
%w(works).each do |person|
  RelationType.find_or_create_by_name(:name => person, :type_name => 'Person')
end

#Product Relation Types as Children
%w(depends).each do |product|
  RelationType.find_or_create_by_name(:name => product, :type_name => 'Product')
end

#Organization Types
%w(Nonprofit Foundation Company City County).each do |org_type|
  OrgType.find_or_create_by_name(:name => org_type)
end

#Note Types
%w(about misc email conversation).each do |note_type|
  NoteType.find_or_create_by_name(:name => note_type)
end
#Whisk Types
[["Geoname", "http://geonames.usgs.gov/"], ["Census County Codes","	http://www.census.gov/datamap/fipslist/AllSt.txt"], ["LongLat", "none"], ["google search", "product"]].each do |whisk_type|
  WhiskType.find_or_create_by_name(:name => whisk_type[0], :setting => whisk_type[1])
end

#Link Types
[["Blog", "Blog"], ["license", "product licenses"], ["RSS Feed",	"none"], ["Website", "Main Website"], ["crunchbase", "none"], ["facebook", "none"], ["twitter", "none"]].each do |link_type|
  LinkType.find_or_create_by_name(:name => link_type[0], :description => link_type[1])
end

#Statistic Type
["Compete"].each do |stat_type|
  StatisticType.find_or_create_by_name(:name => stat_type)
end

if Rails.env!='production'

  #add cities, counties


end
