class CreateRelationships < ActiveRecord::Migration
  def self.up
    create_table :relationships do |t|
      t.string  :relation_type
      t.string  :parentable_type
      t.integer  :parentable_id
      t.string  :childable_type
      t.integer  :childable_id
      t.timestamps
    end
  end

  def self.down
    drop_table :relationships
  end
end
