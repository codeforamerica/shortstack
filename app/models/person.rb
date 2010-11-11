class Person < ActiveRecord::Base
  default_scope order("name ASC")  
  has_many :contributions, :as => :contributable, :class_name => "Contribution"
  has_many :notes, :as => :noteable, :class_name => "Note"
  has_many :links, :as => :linkable, :class_name => "Link"
  has_many :relationships  
  has_many :products, :through => :relationships
  has_many :organizations, :through => :relationships
  has_many :addresses, :as => :addressable, :class_name => "Address"
  has_many :contacts, :as => :contactable, :class_name => "Contact"  

  accepts_nested_attributes_for :contacts
  accepts_nested_attributes_for :addresses
  accepts_nested_attributes_for :links
  accepts_nested_attributes_for :notes
  accepts_nested_attributes_for :relationships  

  after_create :create_contribution
  after_update :update_contribution  
  
  def create_contribution
    self.contributions << Contribution.new(:user =>$current_user, :action => "Create")
  end
  
  def update_contribution
    self.contributions << Contribution.new(:user =>$current_user, :action => "Update")
  end
  
end
