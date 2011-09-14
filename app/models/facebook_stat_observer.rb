class FacebookStatObserver < ActiveRecord::Observer
  def after_save(stat)
    #Find the Facebook Summary
    summary = FacebookSummary.where(:link_id => stat.link_id).first
    #update the attributes
    if !summary.blank?
      #or create new summary
      summary.update_attributes(make_attr_hash(stat))
    else
      FacebookSummary.create(make_attr_hash(stat).merge(:organization => stat.link.linkable, :link => stat.link))
    end
  end

  private

  def make_attr_hash(stat)
    {
      :facebook_id => stat.facebook_id,
      :name => stat.name,
      :category => stat.category,
      :likes => stat.likes
    }
  end
end
