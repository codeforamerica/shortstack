class ChangeCensusToUseFloats < ActiveRecord::Migration
  def self.up
    change_table :twitter_censuses do |t|
      t.change :fo_trstrank, :float
      t.change :outflux, :float
      t.change :interesting, :float
      t.change :chattiness, :float
      t.change :follow_rate, :float
      t.change :at_trstrank, :float
      t.change :influx, :float
      t.change :enthusiasm, :float
      t.change :feedness, :float
      t.change :sway, :float
      t.change :follow_churn, :float
    end
    change_table :twitter_summaries do |t|
      t.change :outflux, :float
      t.change :interesting, :float
      t.change :chattiness, :float
      t.change :feedness, :float
      t.change :sway, :float
      t.change :follow_rate, :float
    end
  end

  def self.down
    change_table :twitter_censuses do |t|
      t.change :fo_trstrank, :decimal
      t.change :outflux, :decimal
      t.change :interesting, :decimal
      t.change :chattiness, :decimal
      t.change :follow_rate, :decimal
      t.change :at_trstrank, :decimal
      t.change :influx, :decimal
      t.change :enthusiasm, :decimal
      t.change :feedness, :decimal
      t.change :sway, :decimal
      t.change :follow_churn, :decimal
    end
    change_table :twitter_summaries do |t|
      t.change :outflux, :decimal
      t.change :interesting, :decimal
      t.change :chattiness, :decimal
      t.change :feedness, :decimal
      t.change :sway, :decimal
      t.change :follow_rate, :decimal
    end
  end
end
