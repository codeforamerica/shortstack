class ActiveRecord::Base
  scope :relations, lambda {|name| {:joins => :relationships, :conditions => ["relationships.relation_type = ?", name.titleize]}}
end
