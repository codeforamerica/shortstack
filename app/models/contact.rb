class Contact < ActiveRecord::Base
  belongs_to :contactable, :polymorphic => true
  has_many :contributions, :as => :contributable, :class_name => "Contribution", :dependent => :destroy

  def name
    "Contact Details"
  end
end
