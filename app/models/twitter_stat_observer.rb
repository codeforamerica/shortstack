class TwitterStatObserver < ActiveRecord::Observer
  def after_save(stat)
    #Find the Twit Summary
    summary = TwitterSummary.where(:link_id => stat.link_id).first
    #update the attributes
    if !summary.blank?
    #or create new Twit summary
    summary.update_attributes(:followers_count => stat.followers_count  , :following_count => stat.following_count, :listed_count => stat.listed_count, :statuses_count => stat.statuses_count )
    else
      TwitterSummary.create(:organization_id => stat.link.linkable, :link => stat.link, :followers_count => stat.followers_count  , :following_count => stat.following_count, :listed_count => stat.listed_count, :statuses_count => stat.statuses_count )
    end  
  end
end