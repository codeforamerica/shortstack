class Statistic < ActiveRecord::Base
  belongs_to :statistic_type
  belongs_to :statisticable, :polymorphic => true
  has_many :contributions, :as => :contributable, :class_name => "Contribution", :dependent => :destroy

  def name
    statistic_type.name
  end

  def org
    case statisticable.class.name
    when 'Link'
      statisticable.linkable
    else
      statisticable
    end
  end
end
