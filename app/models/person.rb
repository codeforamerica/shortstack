require 'has_many_links'
class Person < ActiveRecord::Base
  include HasManyLinks

  default_scope order("name ASC")

  has_many :whisks, :as => :whiskable, :class_name => "Whisk", :dependent => :destroy
  has_many :notes, :as => :noteable, :class_name => "Note", :dependent => :destroy
  has_many :addresses, :as => :addressable, :class_name => "Address", :dependent => :destroy
  has_many :contacts, :as => :contactable, :class_name => "Contact", :dependent => :destroy
  has_many :parents, :as => :parentable, :class_name => "Relationship", :dependent => :destroy
  has_many :children, :as => :childable, :class_name => "Relationship", :dependent => :destroy
  has_many :statistics, :as => :statisticable, :class_name => "Statistic", :dependent => :destroy

  accepts_nested_attributes_for :contacts
  accepts_nested_attributes_for :addresses
  accepts_nested_attributes_for :notes
  accepts_nested_attributes_for :parents
  accepts_nested_attributes_for :children
  accepts_nested_attributes_for :statistics

  scope :alpha, order("name ASC")
  scope :recent, order("created_at DESC")


  acts_as_taggable


end
