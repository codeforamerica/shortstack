class TwitterSummary < ActiveRecord::Base
  belongs_to :organization
  belongs_to :link
  belongs_to :twitter_stat
  belongs_to :twitter_census

  # twitter stuff
  @@sortable_columns = ['screen_name', 'org_name', 'followers_count', 'following_count', 'statuses_count', 'interesting', 'sway', 'outflux', 'feedness', 'chattiness'].freeze
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
      .includes(:twitter_census)
      .order(c + ' ' + direction)
  end

  def self.sortable_columns
    @@sortable_columns
  end

  def self.sortable_directions
    @@sortable_directions
  end

  def self.average_followers
    @average_followers ||= TwitterSummary.average(:followers_count).round
  end

  def self.average_following
    @average_following ||= TwitterSummary.average(:following_count).round
  end

  def self.average_statuses
    @average_statuses ||= TwitterSummary.average(:statuses_count).round
  end

  def self.averages
    [self.average_followers, self.average_following, self.average_statuses]
  end

  def counts
    [followers_count, following_count, statuses_count]
  end
end
