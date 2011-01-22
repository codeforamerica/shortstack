class Whisk < ActiveRecord::Migration
    def self.up
      create_table :whisks do |t|
        t.string :setting
        t.integer :whiskable_id
        t.string :whiskable_type
        t.integer :whisk_type_id
        t.timestamps
      end
    end

    def self.down
      drop_table :whisks
    end
  end
