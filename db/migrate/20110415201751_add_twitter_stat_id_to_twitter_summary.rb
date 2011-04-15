class AddTwitterStatIdToTwitterSummary < ActiveRecord::Migration
  def self.up
    change_table :twitter_summaries do |t|
      t.belongs_to :twitter_stat
    end
  end

  def self.down
    change_table :twitter_summaries do |t|
      t.remove_belongs_to :twitter_stat
    end
  end
end
