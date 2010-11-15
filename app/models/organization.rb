class Organization < ActiveRecord::Base

  belongs_to :org_type
  has_many :notes, :as => :noteable, :class_name => "Note", :dependent => :destroy
  has_many :links, :as => :linkable, :class_name => "Link", :dependent => :destroy
  has_many :contributions, :as => :contributable, :class_name => "Contribution", :dependent => :destroy
  has_many :addresses, :as => :addressable, :class_name => "Address", :dependent => :destroy
  has_many :contacts, :as => :contactable, :class_name => "Contact" , :dependent => :destroy 
  has_many :parents, :as => :parentable, :class_name => "Relationship", :dependent => :destroy
  has_many :children, :as => :childable, :class_name => "Relationship", :dependent => :destroy
  
  accepts_nested_attributes_for :contacts
  accepts_nested_attributes_for :links  
  accepts_nested_attributes_for :addresses     
  accepts_nested_attributes_for :notes
     
  default_scope order("name ASC")  
  
  validates_presence_of :name, :on => :create, :message => "can't be blank"
  validates_presence_of :org_type, :on => :create, :message => "can't be blank"  
    
  after_create :create_contribution
  after_update :update_contribution 

   
  
  def create_contribution
    self.contributions << Contribution.new(:user =>$current_user, :action => "Create")
  end
  
  def update_contribution
    self.contributions << Contribution.new(:user =>$current_user, :action => "Update")
  end
end
