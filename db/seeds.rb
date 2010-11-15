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
  OrganizationType.create!(:name => org_type)
end

#Note Types
%w(about misc email conversation).each do |note_type|
  NoteType.create!(:name => note_type)
end
