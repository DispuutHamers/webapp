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

ActiveRecord::Schema.define(version: 20150630074607) do

  create_table "api_keys", force: :cascade do |t|
    t.string   "key",        limit: 255
    t.integer  "user_id",    limit: 4
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "api_logs", force: :cascade do |t|
    t.string   "ip_addr",       limit: 255
    t.text     "resource_call", limit: 65535
    t.integer  "user_id",       limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "key",           limit: 255
  end

  create_table "arms", force: :cascade do |t|
    t.string   "lat",        limit: 255
    t.string   "lon",        limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
  end

  create_table "devices", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "device_key", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
  end

  create_table "groups", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "group_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groups", ["group_id"], name: "index_groups_on_group_id", using: :btree
  add_index "groups", ["user_id", "group_id"], name: "index_groups_on_user_id_and_group_id", unique: true, using: :btree
  add_index "groups", ["user_id"], name: "index_groups_on_user_id", using: :btree

  create_table "meetings", force: :cascade do |t|
    t.text     "agenda",     limit: 65535
    t.text     "notes",      limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "onderwerp",  limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "date"
  end

  create_table "motions", force: :cascade do |t|
    t.string   "motion_type", limit: 255
    t.string   "subject",     limit: 255
    t.text     "content",     limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",     limit: 4
  end

  create_table "news", force: :cascade do |t|
    t.string   "cat",        limit: 255
    t.text     "body",       limit: 65535
    t.string   "title",      limit: 255
    t.string   "image",      limit: 255
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",    limit: 4
  end

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
  end

  create_table "pushes", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.text     "data",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quotes", force: :cascade do |t|
    t.string   "text",       limit: 255
    t.integer  "user_id",    limit: 4
    t.integer  "reporter",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "quotes", ["user_id", "created_at"], name: "index_quotes_on_user_id_and_created_at", using: :btree

  create_table "reviews", force: :cascade do |t|
    t.integer  "beer_id",     limit: 4
    t.integer  "user_id",     limit: 4
    t.text     "description", limit: 65535
    t.integer  "rating",      limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "proefdatum"
  end

  create_table "signups", force: :cascade do |t|
    t.integer  "event_id",   limit: 4
    t.integer  "user_id",    limit: 4
    t.boolean  "status"
    t.string   "reason",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "usergroups", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",       limit: 255
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "email",           limit: 255
    t.boolean  "approved",                    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest", limit: 255
    t.string   "remember_token",  limit: 255
    t.boolean  "admin",                       default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.boolean  "result"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "poll_id",    limit: 4
  end

end
