class Organization < ActiveRecord::Base

  belongs_to :org_type
  has_many :notes, :as => :noteable, :class_name => "Note", :dependent => :destroy
  has_many :whisks, :as => :whiskable, :class_name => "Whisk", :dependent => :destroy
  has_many :links, :as => :linkable, :class_name => "Link", :dependent => :destroy
  has_many :contributions, :as => :contributable, :class_name => "Contribution", :dependent => :destroy
  has_many :addresses, :as => :addressable, :class_name => "Address", :dependent => :destroy
  has_many :contacts, :as => :contactable, :class_name => "Contact" , :dependent => :destroy
  has_many :parents, :as => :parentable, :class_name => "Relationship", :dependent => :destroy
  has_many :children, :as => :childable, :class_name => "Relationship", :dependent => :destroy
  has_many :statistics, :as => :statisticable, :class_name => "Statistic", :dependent => :destroy

  accepts_nested_attributes_for :contacts
  accepts_nested_attributes_for :links
  accepts_nested_attributes_for :addresses
  accepts_nested_attributes_for :notes
  accepts_nested_attributes_for :statistics

  scope :alpha, order("name ASC")
  scope :recent, order("created_at DESC")

  validates_presence_of :name, :on => :create, :message => "can't be blank"
  validates_presence_of :org_type, :on => :create, :message => "can't be blank"

  after_create :create_contribution
  after_update :update_contribution

  acts_as_taggable

  searchable do
    text :name, :default_boost => 2
    integer :id
    time :updated_at

    text :notes do
      notes.map { |note| note.note }
    end
    text :note_names do
      notes.map { |note| note.name }
    end

    text :links do
      links.map { |link| link.link_url }
    end
    text :link_names do
      links.map { |link| link.name }
    end

    text :zip_codes do
      addresses.map { |address| address.zipcode }
    end
    text :addresses do
      addresses.map { |address| "#{address.address} #{address.city}, #{address.state}" }
    end
  end

  def create_contribution
    self.contributions << Contribution.new(:user =>$current_user, :action => "Create")
  end

  def update_contribution
    self.contributions << Contribution.new(:user =>$current_user, :action => "Update")
  end
end
