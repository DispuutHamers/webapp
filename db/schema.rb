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

ActiveRecord::Schema.define(version: 20140327150929) do

  create_table "events", force: true do |t|
    t.string   "beschrijving"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "polls", force: true do |t|
    t.string   "beschrijving"
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

  create_table "signups", force: true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.boolean  "status"
    t.string   "reason"
    t.datetime "created_at"
    t.datetime "updated_at"
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
