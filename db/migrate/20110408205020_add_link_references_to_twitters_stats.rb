class AddLinkReferencesToTwittersStats < ActiveRecord::Migration
  def self.up
    change_table :twitter_stats do |t|
      t.references :link
    end
  end

  def self.down
    change_table :twitter_stats do |t|
      t.remove_references :link
    end
  end
end
