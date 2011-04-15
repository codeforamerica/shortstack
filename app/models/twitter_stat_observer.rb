class TwitterStatObserver < ActiveRecord::Observer
  def after_save(stat)
    #Find the Twit Summary
    summary = TwitterSummary.where(:link_id => stat.link_id).first
    #update the attributes
    if summary
      #or create new Twit summary
      summary.update_attributes(make_attr_hash(stat))
    else
      TwitterSummary.create(make_attr_hash(stat).merge(:organization_id => stat.link.linkable, :link => stat.link))
    end  
  end

  private

  def make_attr_hash(stat)
    {
      :screen_name => stat.screen_name,
      :followers_count => stat.followers_count,
      :following_count => stat.following_count,
      :listed_count => stat.listed_count,
      :statuses_count => stat.statuses_count,
    }
  end
end
