class CreateContributions < ActiveRecord::Migration
  def self.up
    create_table :contributions do |t|
      t.integer :user_id
      t.integer :contributable_id
      t.string :contributable_type
      t.string :action

      t.timestamps
    end
  end

  def self.down
    drop_table :contributions
  end
end
