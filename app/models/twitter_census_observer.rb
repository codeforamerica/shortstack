class TwitterStatObserver < ActiveRecord::Observer
  def after_save(stat)
    #Find the Twit Summary
    summary = TwitterSummary.where(:link_id => stat.link_id).first
    #update the attributes
    if !summary.blank?
      #or create new Twit summary
      summary.update_attributes(make_attr_hash(stat))
    else
      TwitterSummary.create(make_attr_hash(stat).merge(:organization => stat.link.linkable, :link => stat.link))
    end  
  end

  private

  def make_attr_hash(census)
    {
      :twitter_census => census,
      :outflux => census.outflux,
      :interesting => census.interesting,
      :chattiness => census.chattiness,
      :follow_rate => census.follow_rate,
      :feedness => census.feedness,
      :sway => census.sway
    }
  end
end
