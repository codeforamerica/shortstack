class CreateStatisticTypes < ActiveRecord::Migration
  def self.up
    create_table :statistic_types do |t|
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :statistic_types
  end
end
