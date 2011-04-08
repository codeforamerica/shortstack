class CreateTwitterStats < ActiveRecord::Migration
  def self.up
    create_table :twitter_stats do |t|
      t.datetime :created
      # t.boolean :default_profile
      # t.boolean :default_profile_image
      t.string :description
      # t.boolean :follow_request_sent
      # t.boolean :following
      t.integer :favourites_count
      t.integer :followers_count
      t.integer :following_count
      t.boolean :geo_enabled
      t.integer :listed_count
      t.string :profile_background_color
      t.string :profile_background_image_url
      t.string :profile_background_tile
      t.string :profile_image_url
      t.string :profile_link_color
      t.string :profile_sidebar_border_color
      t.string :profile_sidebar_fill_color
      t.string :profile_text_color
      t.string :screen_name
      t.integer :statuses_count
      t.string :time_zone
      t.string :url
      t.boolean :verified

      t.timestamps
    end
  end

  def self.down
    drop_table :twitter_stats
  end
end
