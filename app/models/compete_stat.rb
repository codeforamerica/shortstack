require 'compete'
COMPETE_API_KEY = ENV["COMPETE_API_KEY"]  
    
class CompeteStat
  
  def initialize(link)
    @link = link
  end
  
  # get the compete score for the link
  #
  # @return Integer or nil
  def get_compete_score
  
    info = Compete.for_domain(@link.link_url)
    if info.data_available?
      info.metrics_count == 0 ? nil : info.metrics_count
    else
      nil
    end
  end
  
  # create a new statistic with data
  #
  # @return Statistic
  def create_statistic
    stat_type = StatisticType.find_by_name('Compete') 
    score = get_compete_score
    Statistic.create!(:statisticable => @link, :statistic_type => stat_type, :value => score) unless score.nil?
  end
  
  
end