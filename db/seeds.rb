#Organization Relation Types
%w(funds owns sponsors services uses).each do |org|
  RelationType.create!(:name => org, :type_name => 'Organization')
end
#Person Relation Types
%w(funds codes works board).each do |person|
  RelationType.create!(:name => person, :type_name => 'Person')
end

#Organization Types
%w(nonprofit foundation company).each do |org_type|
  OrganizationType.create!(:name => org_type)
end

#Note Types
%w(about misc email conversation).each do |note_type|
  NoteType.create!(:name => note_type)
end
