class Contribution < ActiveRecord::Base
    belongs_to :user
    belongs_to :contributable, :polymorphic => true
    
    def top_contributors
      Contribution.group(:user_id)
    end
    
end
