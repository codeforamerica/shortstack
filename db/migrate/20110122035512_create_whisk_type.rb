class CreateWhiskType < ActiveRecord::Migration
  def self.up
    create_table :whisk_types do |t|
      t.string :name
      t.string :setting
      t.timestamps
    end
  end

  def self.down
    drop_table :whisk_types
  end
end

