class Person < ActiveRecord::Base
  default_scope order("name ASC")  
  has_many :contributions, :as => :contributable, :class_name => "Contribution"
  has_many :notes, :as => :noteable, :class_name => "Note"
  has_many :links, :as => :linkable, :class_name => "Link"
  has_many :addresses, :as => :addressable, :class_name => "Address"
  has_many :contacts, :as => :contactable, :class_name => "Contact"  
  has_many :parents, :as => :parentable, :class_name => "Relationship"
  has_many :children, :as => :childable, :class_name => "Relationship"      

  accepts_nested_attributes_for :contacts
  accepts_nested_attributes_for :addresses
  accepts_nested_attributes_for :links
  accepts_nested_attributes_for :notes
  accepts_nested_attributes_for :parents
  accepts_nested_attributes_for :children

  default_scope order("name ASC")  

  after_create :create_contribution
  after_update :update_contribution  
  
  searchable do
    text :name
  end
  
  def create_contribution
    self.contributions << Contribution.new(:user =>$current_user, :action => "Create")
  end
  
  def update_contribution
    self.contributions << Contribution.new(:user =>$current_user, :action => "Update")
  end
  
end
