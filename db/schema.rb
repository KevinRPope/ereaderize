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

ActiveRecord::Schema.define(:version => 20101230043220) do

  create_table "articles", :force => true do |t|
    t.string   "url"
    t.string   "stripped_url"
    t.string   "parameters"
    t.integer  "site_id"
    t.string   "to_email"
    t.integer  "times_sent"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "content"
  end

  add_index "articles", ["site_id"], :name => "index_articles_on_site_id"

  create_table "sites", :force => true do |t|
    t.string   "domain"
    t.text     "code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "articles_count", :default => 0
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "gender"
    t.datetime "birthdate"
    t.string   "hashed_password"
    t.string   "pwsalt"
    t.string   "guid"
    t.integer  "access_level",     :default => 0
    t.boolean  "confirmed_opt_in", :default => false
    t.boolean  "account_inactive", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ereader_email"
  end

end
