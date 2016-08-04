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

ActiveRecord::Schema.define(version: 20160804165516) do

  create_table "albums", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "deleted_at"
  end

  add_index "albums", ["deleted_at"], name: "index_albums_on_deleted_at"

  create_table "api_keys", force: :cascade do |t|
    t.string   "key"
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "api_keys", ["deleted_at"], name: "index_api_keys_on_deleted_at"

  create_table "api_logs", force: :cascade do |t|
    t.string   "ip_addr"
    t.text     "resource_call"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "key"
    t.datetime "deleted_at"
  end

  add_index "api_logs", ["deleted_at"], name: "index_api_logs_on_deleted_at"

  create_table "arms", force: :cascade do |t|
    t.string   "lat"
    t.string   "lon"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "arms", ["deleted_at"], name: "index_arms_on_deleted_at"

  create_table "beers", force: :cascade do |t|
    t.string   "name"
    t.string   "soort"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture"
    t.string   "percentage"
    t.string   "brewer"
    t.string   "country"
    t.string   "URL"
    t.datetime "deleted_at"
    t.float    "grade"
  end

  add_index "beers", ["deleted_at"], name: "index_beers_on_deleted_at"

  create_table "devices", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "device_key"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "devices", ["deleted_at"], name: "index_devices_on_deleted_at"

  create_table "documentation_pages", force: :cascade do |t|
    t.string   "title"
    t.string   "permalink"
    t.text     "content"
    t.text     "compiled_content"
    t.integer  "parent_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documentation_screenshots", force: :cascade do |t|
    t.string "alt_text"
  end

  create_table "events", force: :cascade do |t|
    t.text     "beschrijving"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.datetime "date"
    t.integer  "user_id"
    t.datetime "deadline"
    t.datetime "end_time"
    t.string   "location"
    t.datetime "deleted_at"
  end

  add_index "events", ["deleted_at"], name: "index_events_on_deleted_at"

  create_table "groups", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "groups", ["deleted_at"], name: "index_groups_on_deleted_at"
  add_index "groups", ["group_id"], name: "index_groups_on_group_id"
  add_index "groups", ["user_id", "group_id"], name: "index_groups_on_user_id_and_group_id", unique: true
  add_index "groups", ["user_id"], name: "index_groups_on_user_id"

  create_table "images", force: :cascade do |t|
    t.string   "title"
    t.string   "image_id"
    t.string   "description"
    t.integer  "album_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "deleted_at"
  end

  add_index "images", ["deleted_at"], name: "index_images_on_deleted_at"

  create_table "meetings", force: :cascade do |t|
    t.text     "agenda"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "onderwerp"
    t.integer  "user_id"
    t.datetime "date"
    t.datetime "deleted_at"
  end

  add_index "meetings", ["deleted_at"], name: "index_meetings_on_deleted_at"

  create_table "motions", force: :cascade do |t|
    t.string   "motion_type"
    t.string   "subject"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.datetime "deleted_at"
  end

  add_index "motions", ["deleted_at"], name: "index_motions_on_deleted_at"

  create_table "news", force: :cascade do |t|
    t.string   "cat"
    t.text     "body"
    t.string   "title"
    t.string   "image"
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.datetime "deleted_at"
  end

  add_index "news", ["deleted_at"], name: "index_news_on_deleted_at"

  create_table "nicknames", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "nickname"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "deleted_at"
  end

  add_index "nicknames", ["deleted_at"], name: "index_nicknames_on_deleted_at"
  add_index "nicknames", ["user_id"], name: "index_nicknames_on_user_id"

  create_table "nifty_attachments", force: :cascade do |t|
    t.integer  "parent_id"
    t.string   "parent_type"
    t.string   "token"
    t.string   "digest"
    t.string   "role"
    t.string   "file_name"
    t.string   "file_type"
    t.binary   "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  add_index "notes", ["deleted_at"], name: "index_notes_on_deleted_at"

  create_table "public_pages", force: :cascade do |t|
    t.text     "content"
    t.string   "title"
    t.boolean  "public"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "public_pages", ["deleted_at"], name: "index_public_pages_on_deleted_at"

  create_table "pushes", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "pushes", ["deleted_at"], name: "index_pushes_on_deleted_at"

  create_table "quotes", force: :cascade do |t|
    t.string   "text"
    t.integer  "user_id"
    t.integer  "reporter"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "quotes", ["deleted_at"], name: "index_quotes_on_deleted_at"
  add_index "quotes", ["user_id", "created_at"], name: "index_quotes_on_user_id_and_created_at"

  create_table "reviews", force: :cascade do |t|
    t.integer  "beer_id"
    t.integer  "user_id"
    t.text     "description"
    t.integer  "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "proefdatum"
    t.datetime "deleted_at"
  end

  add_index "reviews", ["deleted_at"], name: "index_reviews_on_deleted_at"

  create_table "signups", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.boolean  "status"
    t.string   "reason"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "signups", ["deleted_at"], name: "index_signups_on_deleted_at"

  create_table "stickers", force: :cascade do |t|
    t.string   "lat"
    t.string   "lon"
    t.text     "notes"
    t.text     "picture"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  add_index "stickers", ["deleted_at"], name: "index_stickers_on_deleted_at"

  create_table "usergroups", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.datetime "deleted_at"
  end

  add_index "usergroups", ["deleted_at"], name: "index_usergroups_on_deleted_at"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.boolean  "approved",        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
    t.integer  "batch"
    t.boolean  "anonymous"
    t.datetime "deleted_at"
    t.float    "weight",          default: 0.0
  end

  add_index "users", ["deleted_at"], name: "index_users_on_deleted_at"
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

  create_table "votes", force: :cascade do |t|
    t.integer  "user_id"
    t.boolean  "result"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "poll_id"
    t.datetime "deleted_at"
  end

  add_index "votes", ["deleted_at"], name: "index_votes_on_deleted_at"

end
