class OrgType < ActiveRecord::Base
  has_many :organizations
  validates_presence_of :name, :on => :create, :message => "can't be blank"
end
