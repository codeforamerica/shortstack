class AlterFacebookIdColumn < ActiveRecord::Migration
  def self.up
    remove_column :facebook_stats, :facebook_id
    add_column :facebook_stats, :facebook_id, :string
    remove_column :facebook_summaries, :facebook_id
    add_column :facebook_summaries, :facebook_id, :string
    
  end

  def self.down
    remove_column :facebook_stats, :facebook_id
    add_column :facebook_stats, :facebook_id, :integer    
    remove_column :facebook_summaries, :facebook_id    
    add_column :facebook_summaries, :facebook_id, :integer

  end
end