class Address < ActiveRecord::Base
  belongs_to :addressable, :polymorphic => true
  has_many :contributions, :as => :contributable, :class_name => "Contribution", :dependent => :destroy

  def name
    "Address"
  end

  def map_json
  end

end
