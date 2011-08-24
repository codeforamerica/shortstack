class AddOrgIdToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :organization_id, :integer
  end

  def self.down
    remove_column :products, :organization_id
  end
end
