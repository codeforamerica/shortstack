class Whisk < ActiveRecord::Base
  belongs_to :whisk_type
  belongs_to :whiskable, :polymorphic => true
  has_many :contributions, :as => :contributable, :class_name => "Contribution", :dependent => :destroy
  after_update :update_contribution  
  after_create :create_contribution
  
  def create_contribution
    self.contributions << Contribution.new(:user =>$current_user, :action => "Create")
  end

  def update_contribution
    self.contributions << Contribution.new(:user =>$current_user, :action => "Update")
  end
end
