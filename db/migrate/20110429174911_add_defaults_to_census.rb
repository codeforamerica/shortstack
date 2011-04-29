class AddDefaultsToCensus < ActiveRecord::Migration
  def self.up
    change_table :twitter_censuses do |t|
      t.change_default :fo_trstrank, 0
      t.change_default :outflux, 0
      t.change_default :interesting, 0
      t.change_default :chattiness, 0
      t.change_default :follow_rate, 0
      t.change_default :at_trstrank, 0
      t.change_default :influx, 0
      t.change_default :enthusiasm, 0
      t.change_default :feedness, 0
      t.change_default :sway, 0
      t.change_default :follow_churn, 0
    end
    change_table :twitter_summaries do |t|
      t.change_default :outflux, 0
      t.change_default :interesting, 0
      t.change_default :chattiness, 0
      t.change_default :feedness, 0
      t.change_default :sway, 0
      t.change_default :follow_rate, 0
    end
  end

  def self.down
  end
end
