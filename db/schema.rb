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

ActiveRecord::Schema.define(version: 20170316135238) do

  create_table "afmeldingens", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "reden"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "albums", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_albums_on_deleted_at", using: :btree
  end

  create_table "api_keys", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "key"
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_api_keys_on_deleted_at", using: :btree
  end

  create_table "api_logs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "ip_addr"
    t.text     "resource_call", limit: 65535
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "key"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_api_logs_on_deleted_at", using: :btree
  end

  create_table "arms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "lat"
    t.string   "lon"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_arms_on_deleted_at", using: :btree
  end

  create_table "beers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
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
    t.float    "grade",      limit: 53
    t.index ["deleted_at"], name: "index_beers_on_deleted_at", using: :btree
  end

  create_table "devices", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "user_id"
    t.string   "device_key"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_devices_on_deleted_at", using: :btree
  end

  create_table "documentation_pages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "title"
    t.string   "permalink"
    t.text     "content",          limit: 65535
    t.text     "compiled_content", limit: 65535
    t.integer  "parent_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documentation_screenshots", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "alt_text"
  end

  create_table "emails", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "from"
    t.string   "to"
    t.text     "body",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "events", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.text     "beschrijving", limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.datetime "date"
    t.integer  "user_id"
    t.datetime "deadline"
    t.datetime "end_time"
    t.string   "location"
    t.datetime "deleted_at"
    t.boolean  "attendance",                 default: false
    t.index ["deleted_at"], name: "index_events_on_deleted_at", using: :btree
  end

  create_table "groups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_groups_on_deleted_at", using: :btree
    t.index ["group_id"], name: "index_groups_on_group_id", using: :btree
    t.index ["user_id", "group_id"], name: "index_groups_on_user_id_and_group_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_groups_on_user_id", using: :btree
  end

  create_table "images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "title"
    t.string   "image_id"
    t.string   "description"
    t.integer  "album_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_images_on_deleted_at", using: :btree
  end

  create_table "meetings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.text     "agenda",     limit: 65535
    t.text     "notes",      limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "onderwerp"
    t.integer  "user_id"
    t.datetime "date"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_meetings_on_deleted_at", using: :btree
  end

  create_table "motions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "motion_type"
    t.string   "subject"
    t.text     "content",     limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_motions_on_deleted_at", using: :btree
  end

  create_table "news", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "cat"
    t.text     "body",       limit: 65535
    t.string   "title"
    t.string   "image"
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_news_on_deleted_at", using: :btree
  end

  create_table "nicknames", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "user_id"
    t.string   "nickname"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_nicknames_on_deleted_at", using: :btree
    t.index ["user_id"], name: "index_nicknames_on_user_id", using: :btree
  end

  create_table "nifty_attachments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "parent_id"
    t.string   "parent_type"
    t.string   "token"
    t.string   "digest"
    t.string   "role"
    t.string   "file_name"
    t.string   "file_type"
    t.binary   "data",        limit: 16777215
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "title"
    t.text     "content",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_notes_on_deleted_at", using: :btree
  end

  create_table "polls", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "beschrijving"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "public_pages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.text     "content",    limit: 65535
    t.string   "title"
    t.boolean  "public"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_public_pages_on_deleted_at", using: :btree
  end

  create_table "pushes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "user_id"
    t.text     "data",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_pushes_on_deleted_at", using: :btree
  end

  create_table "quotes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "text"
    t.integer  "user_id"
    t.integer  "reporter"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_quotes_on_deleted_at", using: :btree
    t.index ["user_id", "created_at"], name: "index_quotes_on_user_id_and_created_at", using: :btree
  end

  create_table "reviews", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "beer_id"
    t.integer  "user_id"
    t.text     "description", limit: 65535
    t.integer  "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "proefdatum"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_reviews_on_deleted_at", using: :btree
  end

  create_table "signups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.boolean  "status"
    t.string   "reason"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_signups_on_deleted_at", using: :btree
  end

  create_table "statics", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "title"
    t.string   "content"
    t.string   "p_content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stickers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "lat"
    t.string   "lon"
    t.text     "notes",      limit: 65535
    t.text     "picture",    limit: 65535
    t.integer  "user_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_stickers_on_deleted_at", using: :btree
  end

  create_table "usergroups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_usergroups_on_deleted_at", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.string   "email"
    t.boolean  "approved",                   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",                      default: false
    t.integer  "batch"
    t.boolean  "anonymous"
    t.datetime "deleted_at"
    t.float    "weight",          limit: 53, default: 0.0
    t.index ["deleted_at"], name: "index_users_on_deleted_at", using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["remember_token"], name: "index_users_on_remember_token", using: :btree
  end

  create_table "versions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string   "item_type",          limit: 191,        null: false
    t.integer  "item_id",                               null: false
    t.string   "event",                                 null: false
    t.string   "whodunnit"
    t.text     "old_object",         limit: 4294967295
    t.datetime "created_at"
    t.text     "old_object_changes", limit: 4294967295
    t.json     "object"
    t.json     "object_changes"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree
  end

  create_table "votes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "user_id"
    t.boolean  "result"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "poll_id"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_votes_on_deleted_at", using: :btree
  end

  add_foreign_key "nicknames", "users"
end
