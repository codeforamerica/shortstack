class AddParentToRelationTypes < ActiveRecord::Migration
  def self.up
    add_column :relation_types, :parent, :boolean, :default => false
  end

  def self.down
    remove_column :relation_types, :parent
  end
end
