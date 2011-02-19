class CreateStatistics < ActiveRecord::Migration
  def self.up
    create_table :statistics do |t|
      t.string :value
      t.integer :statisticable_id
      t.string :statisticable_type
      t.integer :statistic_type_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :statistics
  end
end
