require 'has_many_links'
class Product < ActiveRecord::Base

  include HasManyLinks

  has_many :notes, :as => :noteable, :class_name => "Note", :dependent => :destroy

  has_many :screenshots, :as => :shottable, :class_name => "Screenshot", :dependent => :destroy
  has_many :whisks, :as => :whiskable, :class_name => "Whisk", :dependent => :destroy
  has_many :contacts, :as => :contactable, :class_name => "Contact", :dependent => :destroy
  has_many :addresses, :as => :addressable, :class_name => "Address", :dependent => :destroy
  has_many :statistics, :as => :statisticable, :class_name => "Statistic", :dependent => :destroy
  belongs_to :organization
  
  validates_presence_of :name, :on => :create, :message => "can't be blank"
  validates_uniqueness_of :name, :on => :create, :message => "must be unique"

  accepts_nested_attributes_for :contacts
  accepts_nested_attributes_for :addresses
  accepts_nested_attributes_for :notes
  accepts_nested_attributes_for :statistics

  scope :alpha, order("LOWER(name) ASC")
  scope :recent, order("created_at DESC")

  acts_as_taggable

  searchable do
    text :name, :default_boost => 2
    integer :id
    time :updated_at

    text :note_names do
      notes.map { |note| note.name }
    end
    text :notes, :stored => true do
      notes.map { |note| note.note }
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

  attr_accessible :crunchbase, :name, :tag_list

  validates_presence_of :name

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
    if ! url.empty?
      if crunchbase
        crunchbase.link_url = url
      else
        @crunchbase = links.build(:link_type => crunch_lt, :name => 'Crunchbase', :link_url => url)
      end
    end
  end

  def crunch_lt
    @crunch_lt = LinkType.where(:name => 'crunchbase').first
  end
end
