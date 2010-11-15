#Organization Relation Types as Parents
%w(funds owns sponsors services).each do |org|
  RelationType.create!(:name => org, :type_name => 'Organization', :parent => true)
end

#Organization Relation Types as Children
%w(uses).each do |org|
  RelationType.create!(:name => org, :type_name => 'Organization')
end

#Person Relation Types as Parents
%w(funds codes board services owns).each do |person|
  RelationType.create!(:name => person, :type_name => 'Person', :parent => true)
end

#Person Relation Types as Child
%w(works).each do |person|
  RelationType.create!(:name => person, :type_name => 'Person')
end

#Product Relation Types as Children
%w(depends).each do |product|
  RelationType.create!(:name => product, :type_name => 'Product')
end

#Organization Types
%w(nonprofit foundation company).each do |org_type|
  OrgType.create!(:name => org_type)
end

#Note Types
%w(about misc email conversation).each do |note_type|
  NoteType.create!(:name => note_type)
end

#Social Account Settings
[['github_key', 'bc26368331e1c5448ad8'],['github_secret', '12d49cf3bc803557934f396e739a388d1151af8d'],['facebook_key', '159760180721815'],['facebook_secret', '91ac6ce27fcb09d6b65d8be47c47784e'],['twitter_key', 'g6ECF8TKdbGQQI7bgkKVg'], ['twitter_secret', 'WIIaOGyBkOo0Y1kOpkBMYJEPgLNHiskLmvOWGGQnZkI']].each do |setting|
  Setting.create!(:name => setting[0], :setting => setting[1])
end  