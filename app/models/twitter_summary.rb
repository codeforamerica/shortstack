class TwitterSummary < ActiveRecord::Base
  belongs_to :organization
  belongs_to :link

  # twitter stuff
  @@sortable_columns = ['screen_name', 'org_name', 'followers_count', 'following_count', 'statuses_count'].freeze
  @@sortable_directions = ['asc', 'desc'].freeze

  def self.sortable_columns
    @@sortable_columns
  end

  def self.sortable_directions
    @@sortable_directions
  end
end
