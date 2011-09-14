class Note < ActiveRecord::Base
  belongs_to :note_type
  belongs_to :noteable, :polymorphic => true

  scope :about, :joins => :note_type, :conditions => ["note_types.name = 'about'"]
  scope :requirements, :joins => :note_type, :conditions => ["note_types.name = 'requirements'"]
  scope :eula, :joins => :note_type, :conditions => ["note_types.name = 'end user license agreement'"]
  scope :permission, :joins => :note_type, :conditions => ["note_types.name = 'distribution permissions'"]

  def create_contribution
    self.contributions << Contribution.new(:user =>$current_user, :action => "Create")
  end

  def update_contribution
    self.contributions << Contribution.new(:user =>$current_user, :action => "Update")
  end
end
