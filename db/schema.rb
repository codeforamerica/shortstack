# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110429164119) do

  create_table "addresses", :force => true do |t|
    t.string    "address"
    t.string    "city"
    t.string    "state"
    t.string    "zipcode"
    t.string    "country"
    t.string    "lat"
    t.string    "long"
    t.string    "addressable_type"
    t.integer   "addressable_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "authentications", :force => true do |t|
    t.integer   "user_id"
    t.string    "provider"
    t.string    "uid"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "contacts", :force => true do |t|
    t.string    "phone"
    t.string    "email"
    t.string    "twitter"
    t.string    "facebook"
    t.string    "linkedin"
    t.string    "github"
    t.integer   "contactable_id"
    t.string    "contactable_type"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "contributions", :force => true do |t|
    t.integer   "user_id"
    t.integer   "contributable_id"
    t.string    "contributable_type"
    t.string    "action"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer   "priority",   :default => 0
    t.integer   "attempts",   :default => 0
    t.text      "handler"
    t.text      "last_error"
    t.timestamp "run_at"
    t.timestamp "locked_at"
    t.timestamp "failed_at"
    t.string    "locked_by"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "facebook_stats", :force => true do |t|
    t.integer   "link_id"
    t.string    "name"
    t.string    "category"
    t.integer   "likes"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "facebook_id"
  end

  create_table "facebook_summaries", :force => true do |t|
    t.integer   "organization_id"
    t.integer   "link_id"
    t.string    "name"
    t.string    "category"
    t.integer   "likes"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "facebook_id"
  end

  create_table "link_types", :force => true do |t|
    t.string    "name"
    t.string    "description"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "links", :force => true do |t|
    t.string    "name"
    t.text      "link_url"
    t.integer   "linkable_id"
    t.string    "linkable_type"
    t.integer   "link_type_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "flag",          :default => 0
  end

  create_table "note_types", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "notes", :force => true do |t|
    t.string    "name"
    t.text      "note"
    t.integer   "noteable_id"
    t.string    "noteable_type"
    t.integer   "note_type_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "org_types", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "organization_subdomains", :force => true do |t|
    t.integer   "organization_id"
    t.integer   "subdomain_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "organization_subdomains", ["organization_id"], :name => "index_organization_subdomains_on_organization_id"
  add_index "organization_subdomains", ["subdomain_id"], :name => "index_organization_subdomains_on_subdomain_id"

  create_table "organizations", :force => true do |t|
    t.string    "name"
    t.integer   "org_type_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "people", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "products", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "profiles", :force => true do |t|
    t.integer   "user_id"
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.string    "message"
    t.string    "username"
    t.integer   "item"
    t.string    "table"
    t.integer   "month"
    t.integer   "year"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_histories_on_item_and_table_and_month_and_year"

  create_table "relation_types", :force => true do |t|
    t.string    "name"
    t.string    "type_name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.boolean   "parent",     :default => false
  end

  create_table "relationships", :force => true do |t|
    t.string    "relation_type"
    t.string    "parentable_type"
    t.integer   "parentable_id"
    t.string    "childable_type"
    t.integer   "childable_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "settings", :force => true do |t|
    t.string    "name"
    t.string    "setting"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "statistic_types", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "statistics", :force => true do |t|
    t.string    "value"
    t.integer   "statisticable_id"
    t.string    "statisticable_type"
    t.integer   "statistic_type_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "subdomains", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer   "tag_id"
    t.integer   "taggable_id"
    t.string    "taggable_type"
    t.integer   "tagger_id"
    t.string    "tagger_type"
    t.string    "context"
    t.timestamp "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "twitter_censuses", :force => true do |t|
    t.float    "fo_trstrank",  :default => 0.0
    t.integer  "followers"
    t.float    "outflux",      :default => 0.0
    t.float    "interesting",  :default => 0.0
    t.float    "chattiness",   :default => 0.0
    t.integer  "user_id"
    t.float    "follow_rate",  :default => 0.0
    t.string   "screen_name"
    t.float    "at_trstrank",  :default => 0.0
    t.float    "influx",       :default => 0.0
    t.float    "enthusiasm",   :default => 0.0
    t.float    "feedness",     :default => 0.0
    t.float    "sway",         :default => 0.0
    t.float    "follow_churn", :default => 0.0
    t.integer  "link_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "twitter_stats", :force => true do |t|
    t.timestamp "created"
    t.string    "description"
    t.integer   "favourites_count"
    t.integer   "followers_count"
    t.integer   "following_count"
    t.boolean   "geo_enabled"
    t.integer   "listed_count"
    t.string    "profile_background_color"
    t.string    "profile_background_image_url"
    t.string    "profile_background_tile"
    t.string    "profile_image_url"
    t.string    "profile_link_color"
    t.string    "profile_sidebar_border_color"
    t.string    "profile_sidebar_fill_color"
    t.string    "profile_text_color"
    t.string    "screen_name"
    t.integer   "statuses_count"
    t.string    "time_zone"
    t.string    "url"
    t.boolean   "verified"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "link_id"
  end

  create_table "twitter_summaries", :force => true do |t|
    t.integer  "organization_id"
    t.integer  "link_id"
    t.integer  "followers_count"
    t.integer  "following_count"
    t.integer  "listed_count"
    t.integer  "statuses_count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "twitter_stat_id"
    t.float    "outflux",           :default => 0.0
    t.float    "interesting",       :default => 0.0
    t.float    "chattiness",        :default => 0.0
    t.float    "follow_rate",       :default => 0.0
    t.float    "feedness",          :default => 0.0
    t.float    "sway",              :default => 0.0
    t.integer  "twitter_census_id"
  end

  add_index "twitter_summaries", ["link_id"], :name => "index_twitter_summaries_on_link_id"
  add_index "twitter_summaries", ["organization_id"], :name => "index_twitter_summaries_on_organization_id"

  create_table "users", :force => true do |t|
    t.string    "email",                               :default => "",    :null => false
    t.string    "encrypted_password",   :limit => 128, :default => "",    :null => false
    t.string    "password_salt",                       :default => "",    :null => false
    t.string    "reset_password_token"
    t.string    "remember_token"
    t.timestamp "remember_created_at"
    t.integer   "sign_in_count",                       :default => 0
    t.timestamp "current_sign_in_at"
    t.timestamp "last_sign_in_at"
    t.string    "current_sign_in_ip"
    t.string    "last_sign_in_ip"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.boolean   "admin",                               :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "whisk_types", :force => true do |t|
    t.string    "name"
    t.string    "setting"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "whisks", :force => true do |t|
    t.string    "setting"
    t.integer   "whiskable_id"
    t.string    "whiskable_type"
    t.integer   "whisk_type_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

end
