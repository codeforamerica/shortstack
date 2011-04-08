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

ActiveRecord::Schema.define(:version => 20110330191055) do

  create_table "addresses", :force => true do |t|
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "country"
    t.string   "lat"
    t.string   "long"
    t.string   "addressable_type"
    t.integer  "addressable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", :force => true do |t|
    t.string   "phone"
    t.string   "email"
    t.string   "twitter"
    t.string   "facebook"
    t.string   "linkedin"
    t.string   "github"
    t.integer  "contactable_id"
    t.string   "contactable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contributions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "contributable_id"
    t.string   "contributable_type"
    t.string   "action"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "link_types", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "links", :force => true do |t|
    t.string   "name"
    t.text     "link_url"
    t.integer  "linkable_id"
    t.string   "linkable_type"
    t.integer  "link_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "note_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes", :force => true do |t|
    t.string   "name"
    t.text     "note"
    t.integer  "noteable_id"
    t.string   "noteable_type"
    t.integer  "note_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "org_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organization_subdomains", :force => true do |t|
    t.integer  "organization_id"
    t.integer  "subdomain_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "organization_subdomains", ["organization_id"], :name => "index_organization_subdomains_on_organization_id"
  add_index "organization_subdomains", ["subdomain_id"], :name => "index_organization_subdomains_on_subdomain_id"

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.integer  "org_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.string   "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 5
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_histories_on_item_and_table_and_month_and_year"

  create_table "relation_types", :force => true do |t|
    t.string   "name"
    t.string   "type_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "parent",     :default => false
  end

  create_table "relationships", :force => true do |t|
    t.string   "relation_type"
    t.string   "parentable_type"
    t.integer  "parentable_id"
    t.string   "childable_type"
    t.integer  "childable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "settings", :force => true do |t|
    t.string   "name"
    t.string   "setting"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statistic_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statistics", :force => true do |t|
    t.string   "value"
    t.integer  "statisticable_id"
    t.string   "statisticable_type"
    t.integer  "statistic_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subdomains", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "",    :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "",    :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                               :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "whisk_types", :force => true do |t|
    t.string   "name"
    t.string   "setting"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "whisks", :force => true do |t|
    t.string   "setting"
    t.integer  "whiskable_id"
    t.string   "whiskable_type"
    t.integer  "whisk_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
