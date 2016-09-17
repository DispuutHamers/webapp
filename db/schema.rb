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

ActiveRecord::Schema.define(version: 20160917155621) do

  create_table "afmeldingens", force: :cascade do |t|
    t.string   "reden",      limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "albums", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.datetime "deleted_at"
  end

  add_index "albums", ["deleted_at"], name: "index_albums_on_deleted_at", using: :btree

  create_table "api_keys", force: :cascade do |t|
    t.string   "key",        limit: 255
    t.integer  "user_id",    limit: 4
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "api_keys", ["deleted_at"], name: "index_api_keys_on_deleted_at", using: :btree

  create_table "api_logs", force: :cascade do |t|
    t.string   "ip_addr",       limit: 255
    t.text     "resource_call", limit: 65535
    t.integer  "user_id",       limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "key",           limit: 255
    t.datetime "deleted_at"
  end

  add_index "api_logs", ["deleted_at"], name: "index_api_logs_on_deleted_at", using: :btree

  create_table "arms", force: :cascade do |t|
    t.string   "lat",        limit: 255
    t.string   "lon",        limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "arms", ["deleted_at"], name: "index_arms_on_deleted_at", using: :btree

  create_table "beers", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "soort",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture",    limit: 255
    t.string   "percentage", limit: 255
    t.string   "brewer",     limit: 255
    t.string   "country",    limit: 255
    t.string   "URL",        limit: 255
    t.datetime "deleted_at"
    t.float    "grade",      limit: 53
  end

  add_index "beers", ["deleted_at"], name: "index_beers_on_deleted_at", using: :btree

  create_table "devices", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "device_key", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "devices", ["deleted_at"], name: "index_devices_on_deleted_at", using: :btree

  create_table "documentation_pages", force: :cascade do |t|
    t.string   "title",            limit: 255
    t.string   "permalink",        limit: 255
    t.text     "content",          limit: 65535
    t.text     "compiled_content", limit: 65535
    t.integer  "parent_id",        limit: 4
    t.integer  "position",         limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documentation_screenshots", force: :cascade do |t|
    t.string "alt_text", limit: 255
  end

  create_table "emails", force: :cascade do |t|
    t.string   "from",       limit: 255
    t.string   "to",         limit: 255
    t.text     "body",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "events", force: :cascade do |t|
    t.text     "beschrijving", limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title",        limit: 255
    t.datetime "date"
    t.integer  "user_id",      limit: 4
    t.datetime "deadline"
    t.datetime "end_time"
    t.string   "location",     limit: 255
    t.datetime "deleted_at"
  end

  add_index "events", ["deleted_at"], name: "index_events_on_deleted_at", using: :btree

  create_table "groups", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "group_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "groups", ["deleted_at"], name: "index_groups_on_deleted_at", using: :btree
  add_index "groups", ["group_id"], name: "index_groups_on_group_id", using: :btree
  add_index "groups", ["user_id", "group_id"], name: "index_groups_on_user_id_and_group_id", unique: true, using: :btree
  add_index "groups", ["user_id"], name: "index_groups_on_user_id", using: :btree

  create_table "images", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.string   "image_id",    limit: 255
    t.string   "description", limit: 255
    t.integer  "album_id",    limit: 4
    t.integer  "user_id",     limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.datetime "deleted_at"
  end

  add_index "images", ["deleted_at"], name: "index_images_on_deleted_at", using: :btree

  create_table "meetings", force: :cascade do |t|
    t.text     "agenda",     limit: 65535
    t.text     "notes",      limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "onderwerp",  limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "date"
    t.datetime "deleted_at"
  end

  add_index "meetings", ["deleted_at"], name: "index_meetings_on_deleted_at", using: :btree

  create_table "motions", force: :cascade do |t|
    t.string   "motion_type", limit: 255
    t.string   "subject",     limit: 255
    t.text     "content",     limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",     limit: 4
    t.datetime "deleted_at"
  end

  add_index "motions", ["deleted_at"], name: "index_motions_on_deleted_at", using: :btree

  create_table "news", force: :cascade do |t|
    t.string   "cat",        limit: 255
    t.text     "body",       limit: 65535
    t.string   "title",      limit: 255
    t.string   "image",      limit: 255
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",    limit: 4
    t.datetime "deleted_at"
  end

  add_index "news", ["deleted_at"], name: "index_news_on_deleted_at", using: :btree

  create_table "nicknames", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.string   "nickname",    limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.datetime "deleted_at"
  end

  add_index "nicknames", ["deleted_at"], name: "index_nicknames_on_deleted_at", using: :btree
  add_index "nicknames", ["user_id"], name: "index_nicknames_on_user_id", using: :btree

  create_table "nifty_attachments", force: :cascade do |t|
    t.integer  "parent_id",   limit: 4
    t.string   "parent_type", limit: 255
    t.string   "token",       limit: 255
    t.string   "digest",      limit: 255
    t.string   "role",        limit: 255
    t.string   "file_name",   limit: 255
    t.string   "file_type",   limit: 255
    t.binary   "data",        limit: 16777215
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "content",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.datetime "deleted_at"
  end

  add_index "notes", ["deleted_at"], name: "index_notes_on_deleted_at", using: :btree

  create_table "polls", force: :cascade do |t|
    t.string   "beschrijving", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "public_pages", force: :cascade do |t|
    t.text     "content",    limit: 65535
    t.string   "title",      limit: 255
    t.boolean  "public"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "public_pages", ["deleted_at"], name: "index_public_pages_on_deleted_at", using: :btree

  create_table "pushes", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.text     "data",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "pushes", ["deleted_at"], name: "index_pushes_on_deleted_at", using: :btree

  create_table "quotes", force: :cascade do |t|
    t.string   "text",       limit: 255
    t.integer  "user_id",    limit: 4
    t.integer  "reporter",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "quotes", ["deleted_at"], name: "index_quotes_on_deleted_at", using: :btree
  add_index "quotes", ["user_id", "created_at"], name: "index_quotes_on_user_id_and_created_at", using: :btree

  create_table "reviews", force: :cascade do |t|
    t.integer  "beer_id",     limit: 4
    t.integer  "user_id",     limit: 4
    t.text     "description", limit: 65535
    t.integer  "rating",      limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "proefdatum"
    t.datetime "deleted_at"
  end

  add_index "reviews", ["deleted_at"], name: "index_reviews_on_deleted_at", using: :btree

  create_table "signups", force: :cascade do |t|
    t.integer  "event_id",   limit: 4
    t.integer  "user_id",    limit: 4
    t.boolean  "status"
    t.string   "reason",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "signups", ["deleted_at"], name: "index_signups_on_deleted_at", using: :btree

  create_table "statics", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "content",    limit: 255
    t.string   "p_content",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stickers", force: :cascade do |t|
    t.string   "lat",        limit: 255
    t.string   "lon",        limit: 255
    t.text     "notes",      limit: 65535
    t.text     "picture",    limit: 65535
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.datetime "deleted_at"
  end

  add_index "stickers", ["deleted_at"], name: "index_stickers_on_deleted_at", using: :btree

  create_table "usergroups", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",       limit: 255
    t.datetime "deleted_at"
  end

  add_index "usergroups", ["deleted_at"], name: "index_usergroups_on_deleted_at", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "email",           limit: 255
    t.boolean  "approved",                    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest", limit: 255
    t.string   "remember_token",  limit: 255
    t.boolean  "admin",                       default: false
    t.integer  "batch",           limit: 4
    t.boolean  "anonymous"
    t.datetime "deleted_at"
    t.float    "weight",          limit: 53,  default: 0.0
  end

  add_index "users", ["deleted_at"], name: "index_users_on_deleted_at", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.boolean  "result"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "poll_id",    limit: 4
    t.datetime "deleted_at"
  end

  add_index "votes", ["deleted_at"], name: "index_votes_on_deleted_at", using: :btree

  add_foreign_key "nicknames", "users"
end
