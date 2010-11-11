class Link < ActiveRecord::Base
  default_scope order("created_at ASC")
  belongs_to :link_type
  belongs_to :linkable, :polymorphic => true
  has_many :contributions, :as => :contributable, :class_name => "Contribution"
  after_update :update_contribution  
  after_create :create_contribution

  def create_contribution
    self.contributions << Contribution.new(:user =>$current_user, :action => "Create")
  end

  def update_contribution
    self.contributions << Contribution.new(:user =>$current_user, :action => "Update")
  end
  
end
