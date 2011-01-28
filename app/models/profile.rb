class Profile < ActiveRecord::Base
  belongs_to :user
  has_many :contributions, :through => :user

  validates_presence_of :name, :on => :create, :message => "can't be blank"
  default_scope order("name ASC")  
end
