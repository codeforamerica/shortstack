require 'has_many_links'
class Organization < ActiveRecord::Base
  include HasManyLinks

  belongs_to :org_type
  has_many :notes, :as => :noteable, :class_name => "Note", :dependent => :destroy
  has_many :whisks, :as => :whiskable, :class_name => "Whisk", :dependent => :destroy
  has_many :contributions, :as => :contributable, :class_name => "Contribution", :dependent => :destroy
  has_many :addresses, :as => :addressable, :class_name => "Address", :dependent => :destroy
  has_many :contacts, :as => :contactable, :class_name => "Contact" , :dependent => :destroy
  has_many :products
  has_many :parents, :as => :parentable, :class_name => "Relationship", :dependent => :destroy
  has_many :children, :as => :childable, :class_name => "Relationship", :dependent => :destroy  
  has_many :statistics, :as => :statisticable, :class_name => "Statistic", :dependent => :destroy
  has_many :twitter_summaries, :dependent => :destroy
  has_many :facebook_summaries, :dependent => :destroy    

  has_many :organization_subdomains
  has_many :subdomains, :through => :organization_subdomains

  accepts_nested_attributes_for :contacts
  accepts_nested_attributes_for :addresses
  accepts_nested_attributes_for :notes
  accepts_nested_attributes_for :statistics

  scope :alpha, order("name ASC")
  scope :recent, order("created_at DESC")
  
  validates_presence_of :name, :on => :create, :message => "can't be blank"
  validates_presence_of :org_type, :on => :create, :message => "can't be blank"

  acts_as_taggable

  searchable do
    text :name, :default_boost => 2
    integer :id
    time :updated_at

    text :notes, :stored => true do
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

  #def find_social_links(type)
  #  lt = LinkType.find_by_name(type.to_s.capitalize)

  #  WhiskBatter.new(self).extract_social_links(type).each do |link|
  #    links << Link.create!(:link_url => link, :link_type => lt)
  #  end
  #end
end
