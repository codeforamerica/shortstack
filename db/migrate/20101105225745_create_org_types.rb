class CreateOrgTypes < ActiveRecord::Migration
  def self.up
    create_table :org_types do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :org_types
  end
end
