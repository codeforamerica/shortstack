class Whisk < ActiveRecord::Base
  belongs_to :whisk_type
  belongs_to :whiskable, :polymorphic => true
  has_many :contributions, :as => :contributable, :class_name => "Contribution", :dependent => :destroy

  def name
    self.whisk_type.name
  end
end
