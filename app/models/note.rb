class Note < ActiveRecord::Base
  belongs_to :note_type
  belongs_to :noteable, :polymorphic => true
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
