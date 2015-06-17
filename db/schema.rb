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

ActiveRecord::Schema.define(version: 20150617132700) do

  create_table "afmeldingens", force: true do |t|
    t.string   "reden"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "api_keys", force: true do |t|
    t.string   "key"
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "beers", force: true do |t|
    t.string   "name"
    t.string   "soort"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture"
    t.string   "percentage"
    t.string   "brewer"
    t.string   "country"
    t.string   "URL"
  end

  create_table "devices", force: true do |t|
    t.integer  "user_id"
    t.string   "device_key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.text     "beschrijving"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.datetime "date"
    t.integer  "user_id"
    t.datetime "deadline"
    t.datetime "end_time"
    t.string   "location"
  end

  create_table "groups", force: true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groups", ["group_id"], name: "index_groups_on_group_id", using: :btree
  add_index "groups", ["user_id", "group_id"], name: "index_groups_on_user_id_and_group_id", unique: true, using: :btree
  add_index "groups", ["user_id"], name: "index_groups_on_user_id", using: :btree

  create_table "meetings", force: true do |t|
    t.text     "agenda"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "onderwerp"
    t.integer  "user_id"
    t.datetime "date"
  end

  create_table "motions", force: true do |t|
    t.string   "motion_type"
    t.string   "subject"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "news", force: true do |t|
    t.string   "cat"
    t.text     "body"
    t.string   "title"
    t.string   "image"
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "polls", force: true do |t|
    t.string   "beschrijving"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "public_pages", force: true do |t|
    t.text     "content"
    t.string   "title"
    t.boolean  "public"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pushes", force: true do |t|
    t.integer  "user_id"
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quotes", force: true do |t|
    t.string   "text"
    t.integer  "user_id"
    t.integer  "reporter"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "quotes", ["user_id", "created_at"], name: "index_quotes_on_user_id_and_created_at", using: :btree

  create_table "reviews", force: true do |t|
    t.integer  "beer_id"
    t.integer  "user_id"
    t.text     "description"
    t.integer  "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "proefdatum"
  end

  create_table "signups", force: true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.boolean  "status"
    t.string   "reason"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statics", force: true do |t|
    t.string   "title"
    t.string   "content"
    t.string   "p_content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "usergroups", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.boolean  "approved",        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

  create_table "votes", force: true do |t|
    t.integer  "user_id"
    t.boolean  "result"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "poll_id"
  end

end
