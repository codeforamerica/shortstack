class CreateRelationships < ActiveRecord::Migration
  def self.up
    create_table :relationships do |t|
      t.integer :person_id
      t.integer :organization_id
      t.integer :product_id
      t.string :relation_type
      t.timestamps
    end
  end

  def self.down
    drop_table :relationships
  end
end
