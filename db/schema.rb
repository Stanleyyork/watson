# encoding: UTF-8
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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160108203115) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "channels", force: :cascade do |t|
    t.string   "category"
    t.integer  "user_id"
    t.date     "date"
    t.text     "content"
    t.integer  "personality_id"
    t.string   "name"
    t.string   "subname"
    t.integer  "num_entries"
    t.string   "url"
    t.string   "image_url"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "year"
  end

  create_table "personalities", force: :cascade do |t|
    t.string   "category"
    t.string   "subcategory"
    t.float    "percentage"
    t.float    "sampling_error"
    t.string   "channel_name"
    t.integer  "user_id"
    t.integer  "channel_id"
    t.date     "date"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "attribute_name"
    t.integer  "year"
    t.string   "title"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "twitter_username"
  end

end
