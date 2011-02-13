class Product < ActiveRecord::Base

  has_many :notes, :as => :noteable, :class_name => "Note", :dependent => :destroy
  has_many :contributions, :as => :contributable, :class_name => "Contribution", :dependent => :destroy
  has_many :whisks, :as => :whiskable, :class_name => "Whisk", :dependent => :destroy
  has_many :parents, :as => :parentable, :class_name => "Relationship", :dependent => :destroy
  has_many :children, :as => :childable, :class_name => "Relationship", :dependent => :destroy
  has_many :links, :as => :linkable, :class_name => "Link", :dependent => :destroy
  has_many :contacts, :as => :contactable, :class_name => "Contact", :dependent => :destroy
  has_many :addresses, :as => :addressable, :class_name => "Address", :dependent => :destroy

  accepts_nested_attributes_for :contacts
  accepts_nested_attributes_for :links
  accepts_nested_attributes_for :addresses
  accepts_nested_attributes_for :notes
  accepts_nested_attributes_for :parents
  accepts_nested_attributes_for :children

  scope :alpha, order("LOWER(name) ASC")
  scope :recent, order("created_at DESC")

  after_create :create_contribution
  after_update :update_contribution

  acts_as_taggable

  searchable do
    text :name, :default_boost => 2
    integer :id
    time :updated_at
  end

  attr_accessible :crunchbase, :name

  validates_presence_of :name
  validates_presence_of :crunchbase, :on => :create

  def create_contribution
    self.contributions << Contribution.new(:user =>$current_user, :action => "Create")
  end

  def update_contribution
    self.contributions << Contribution.new(:user =>$current_user, :action => "Update")
  end

  def crunch_sync
    links.where(:link_type_id => crunch_lt).each do |link|
      puts "crunch_syncing: #{link.link_url}"
      wb = WhiskBatter.new(link)
      wb.crunch_sync(self)
    end
  end

  def whisk_cities
    #grab all cities
    orgtype = OrgType.where(:name => "City").first
    orgs = Organization.where(:org_type_id => orgtype.id)
    countdown = orgs.size
    orgs.each do |org|
      puts "#{org.name}, #{org.id}"
      s = WhiskBatter.new(org)
      s.check_for_product(self)
      countdown = countdown - 1
      puts countdown
    end
  end


  def crunchbase
    @crunchbase.link_url if @crunchbase
  end

  def crunchbase=(url)
    if crunchbase
      crunchbase.link_url = url
    else
      @crunchbase = links.build(:link_type => crunch_lt, :name => 'Crunchbase', :link_url => url)
    end
  end

  def crunch_lt
    @crunch_lt = LinkType.where(:name => 'crunchbase').first
  end
end
