class Link < ActiveRecord::Base
  default_scope order("created_at ASC")
  belongs_to :link_type
  belongs_to :linkable, :polymorphic => true
  has_many :contributions, :as => :contributable, :class_name => "Contribution", :dependent => :destroy
  after_update :update_contribution
  after_create :create_contribution

  def create_contribution
    self.contributions << Contribution.new(:user =>$current_user, :action => "Create")
  end

  def update_contribution
    self.contributions << Contribution.new(:user =>$current_user, :action => "Update")
  end
  
  def check_for_redirect
    response = nil
    response = Net::HTTP.start(link_url.gsub("http://", "").gsub("/", ""), 80).head('/')
    if !response.nil? and response.code == "302" 
      self.update_attributes(:link_url => response["location"])
    end
  end

end
