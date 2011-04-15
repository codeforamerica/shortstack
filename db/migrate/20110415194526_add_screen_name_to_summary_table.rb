class AddScreenNameToSummaryTable < ActiveRecord::Migration
  def self.up
    change_table :twitter_summaries do |t|
      t.string :screen_name
    end
  end

  def self.down
    change_table :twitter_summaries do |t|
      t.remove :screen_name
    end
  end
end
