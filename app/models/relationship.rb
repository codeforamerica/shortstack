class Relationship < ActiveRecord::Base
  belongs_to :parentable, :polymorphic => true
  belongs_to :childable, :polymorphic => true
  scope :role, lambda {|name| {:conditions => ["relationships.relation_type = ?", name]}}   
  
end
