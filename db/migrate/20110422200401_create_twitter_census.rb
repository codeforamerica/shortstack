class CreateTwitterCensus < ActiveRecord::Migration
  def self.up
    create_table :twitter_censuses do |t|
      t.decimal :fo_trstrank
      t.integer :followers
      t.decimal :outflux
      t.decimal :interesting
      t.decimal :chattiness
      t.integer :user_id
      t.decimal :follow_rate
      t.string :screen_name
      t.decimal :at_trstrank
      t.decimal :influx
      t.decimal :enthusiasm
      t.decimal :feedness
      t.decimal :sway
      t.decimal :follow_churn

      t.belongs_to :link
      t.timestamps
    end

    change_table :twitter_summaries do |t|
      t.decimal :outflux, :default => 0
      t.decimal :interesting, :default => 0
      t.decimal :chattiness, :default => 0
      t.decimal :follow_rate, :default => 0
      t.decimal :feedness, :default => 0
      t.decimal :sway, :default => 0
      
      t.belongs_to :twitter_census
    end
  end

  def self.down
    drop_table :twitter_censuses
    change_table :twitter_summaries do |t|
      t.remove :outflux, :interesting, :chattiness, :follow_rate, :feedness, :sway
      t.remove_belongs_to :twitter_census
    end
  end
end
