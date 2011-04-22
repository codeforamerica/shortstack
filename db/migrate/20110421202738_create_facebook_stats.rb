class CreateFacebookStats < ActiveRecord::Migration
  def self.up
    create_table :facebook_stats do |t|
      t.integer :link_id
      t.integer :facebook_id
      t.string :name
      t.string :category
      t.integer :likes

      t.timestamps
    end
  end

  def self.down
    drop_table :facebook_stats
  end
end
