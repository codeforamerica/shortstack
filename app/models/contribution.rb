class Contribution < ActiveRecord::Base
    belongs_to :user
    belongs_to :contributable, :polymorphic => true
    default_scope order('created_at DESC')
    
    def top_contributors
      Contribution.group(:user_id)
    end
        
end
