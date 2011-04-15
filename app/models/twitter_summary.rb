class TwitterSummary < ActiveRecord::Base
  belongs_to :organization
  belongs_to :link
  belongs_to :twitter_stat

  # twitter stuff
  @@sortable_columns = ['screen_name', 'org_name', 'followers_count', 'following_count', 'statuses_count'].freeze
  @@sortable_directions = ['asc', 'desc'].freeze

  def self.sortable(column, direction)
    c = case column
        when 'screen_name'
          'twitter_stats.screen_name'
        when 'org_name'
          'organizations.name'
        else
          'twitter_summaries.' + column
        end

    joins(:organization)
      .joins(:link)
      .joins(:twitter_stat)
      .order(c + ' ' + direction)
  end

  def self.sortable_columns
    @@sortable_columns
  end

  def self.sortable_directions
    @@sortable_directions
  end
end
