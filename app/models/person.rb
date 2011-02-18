class Person < ActiveRecord::Base
  default_scope order("name ASC")
  has_many :contributions, :as => :contributable, :class_name => "Contribution", :dependent => :destroy
  has_many :whisks, :as => :whiskable, :class_name => "Whisk", :dependent => :destroy
  has_many :notes, :as => :noteable, :class_name => "Note", :dependent => :destroy
  has_many :links, :as => :linkable, :class_name => "Link", :dependent => :destroy
  has_many :addresses, :as => :addressable, :class_name => "Address", :dependent => :destroy
  has_many :contacts, :as => :contactable, :class_name => "Contact", :dependent => :destroy
  has_many :parents, :as => :parentable, :class_name => "Relationship", :dependent => :destroy
  has_many :children, :as => :childable, :class_name => "Relationship", :dependent => :destroy

  accepts_nested_attributes_for :contacts
  accepts_nested_attributes_for :addresses
  accepts_nested_attributes_for :links
  accepts_nested_attributes_for :notes
  accepts_nested_attributes_for :parents
  accepts_nested_attributes_for :children

  scope :alpha, order("name ASC")
  scope :recent, order("created_at DESC")

  after_create :create_contribution
  after_update :update_contribution

  acts_as_taggable

  def create_contribution
    self.contributions << Contribution.new(:user =>$current_user, :action => "Create")
  end

  def update_contribution
    self.contributions << Contribution.new(:user =>$current_user, :action => "Update")
  end

end
