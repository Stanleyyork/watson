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

ActiveRecord::Schema.define(version: 20160112192912) do

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

  create_table "personality_descriptions", force: :cascade do |t|
    t.string   "category"
    t.string   "subcategory"
    t.string   "attribute_name"
    t.string   "low_term"
    t.string   "low_description"
    t.string   "high_term"
    t.string   "high_description"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "personality_dual_descriptions", force: :cascade do |t|
    t.string   "category"
    t.string   "primary_subcategory"
    t.string   "secondary_subcategory"
    t.string   "primary_high_secondary_high"
    t.string   "primary_high_secondary_low"
    t.string   "primary_low_secondary_high"
    t.string   "primary_low_secondary_low"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "topics", force: :cascade do |t|
    t.string   "name"
    t.string   "label"
    t.string   "relevance"
    t.string   "website"
    t.string   "dbpedia"
    t.string   "freebase"
    t.string   "yago"
    t.integer  "user_id"
    t.string   "channel_name"
    t.string   "title"
    t.string   "year"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "twitter_username"
    t.string   "provider"
    t.string   "uid"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.string   "facebook_posts"
    t.string   "facebook_access_token"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

end
