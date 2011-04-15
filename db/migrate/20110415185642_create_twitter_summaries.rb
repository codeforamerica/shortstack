class CreateTwitterSummaries < ActiveRecord::Migration
  def self.up
    create_table :twitter_summaries do |t|
      t.integer :organization_id
      t.integer :link_id
      t.integer :followers_count
      t.integer :following_count
      t.integer :listed_count
      t.integer :statuses_count
      t.timestamps
    end
    add_index :twitter_summaries, :organization_id
    add_index :twitter_summaries, :link_id    
  end

  def self.down
    remove_index :twitter_summaries, :link_id
    remove_index :twitter_summaries, :organization_id
    drop_table :twitter_summaries
  end
end