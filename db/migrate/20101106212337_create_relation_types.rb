class CreateRelationTypes < ActiveRecord::Migration
  def self.up
    create_table :relation_types do |t|
      t.string :name
      t.string :type_name

      t.timestamps
    end
  end

  def self.down
    drop_table :relation_types
  end
end
