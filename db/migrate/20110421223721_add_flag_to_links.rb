class AddFlagToLinks < ActiveRecord::Migration
  def self.up
    add_column :links, :flag, :integer, :default => 0
  end

  def self.down
    remove_column :links, :flag
  end
end
