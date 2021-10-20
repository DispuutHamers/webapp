# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_10_10_183530) do

  create_table "action_text_rich_texts", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.text "body", size: :long
    t.string "record_type", limit: 255, null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", precision: 6, null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "api_keys", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "key", limit: 255
    t.integer "user_id"
    t.string "name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_api_keys_on_deleted_at"
  end

  create_table "attendees", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.bigint "meeting_id", null: false
    t.bigint "user_id", null: false
    t.index ["meeting_id"], name: "index_attendees_on_meeting_id"
    t.index ["user_id"], name: "index_attendees_on_user_id"
  end

  create_table "beers", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "name", limit: 255
    t.string "kind", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "picture", limit: 255
    t.string "percentage", limit: 255
    t.string "brewer", limit: 255
    t.string "country", limit: 255
    t.string "URL", limit: 255
    t.datetime "deleted_at"
    t.float "grade", limit: 53
    t.index ["deleted_at"], name: "index_beers_on_deleted_at"
  end

  create_table "blogitems", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "title", limit: 255
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "public", default: false
  end

  create_table "blogphotos", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.integer "blogitem_id"
    t.string "description", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name", limit: 255
    t.string "image_content_type", limit: 255
    t.integer "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "brews", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.text "description"
    t.bigint "recipe_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_brews_on_recipe_id"
  end

  create_table "drafts", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "entity_type", limit: 255
    t.bigint "entity_id"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["entity_type", "entity_id"], name: "index_drafts_on_entity_type_and_entity_id"
  end

  create_table "emails", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "from", limit: 255
    t.string "to", limit: 255
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "title", limit: 255, null: false
    t.datetime "date", null: false
    t.integer "user_id"
    t.datetime "deadline"
    t.datetime "end_time"
    t.string "location", limit: 255
    t.datetime "deleted_at"
    t.boolean "attendance", default: false
    t.string "invitation_code", limit: 255
    t.integer "usergroup_id"
    t.index ["deleted_at"], name: "index_events_on_deleted_at"
  end

  create_table "external_signups", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "first_name", limit: 255
    t.string "last_name", limit: 255
    t.string "email", limit: 255
    t.text "note"
    t.integer "event_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
  end

  create_table "groups", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.integer "user_id"
    t.integer "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_groups_on_deleted_at"
    t.index ["group_id"], name: "index_groups_on_group_id"
    t.index ["user_id", "group_id"], name: "index_groups_on_user_id_and_group_id", unique: true
    t.index ["user_id"], name: "index_groups_on_user_id"
  end

  create_table "gutentag_taggings", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "tag_id", null: false
    t.integer "taggable_id", null: false
    t.string "taggable_type", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tag_id"], name: "index_gutentag_taggings_on_tag_id"
    t.index ["taggable_type", "taggable_id", "tag_id"], name: "unique_taggings", unique: true
    t.index ["taggable_type", "taggable_id"], name: "index_gutentag_taggings_on_taggable_type_and_taggable_id"
  end

  create_table "gutentag_tags", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "taggings_count", default: 0, null: false
    t.index ["name"], name: "index_gutentag_tags_on_name", unique: true
    t.index ["taggings_count"], name: "index_gutentag_tags_on_taggings_count"
  end

  create_table "images", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "title", limit: 255
    t.string "image_id", limit: 255
    t.string "description", limit: 255
    t.integer "album_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_images_on_deleted_at"
  end

  create_table "meetings", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.text "agenda"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "onderwerp", limit: 255
    t.integer "secretary_id"
    t.datetime "date"
    t.datetime "deleted_at"
    t.integer "chairman_id"
    t.index ["deleted_at"], name: "index_meetings_on_deleted_at"
  end

  create_table "news", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "cat", limit: 255
    t.text "body"
    t.string "title", limit: 255
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_news_on_deleted_at"
  end

  create_table "oauth_access_grants", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.integer "resource_owner_id", null: false
    t.integer "application_id", null: false
    t.string "token", limit: 255, null: false
    t.integer "expires_in", null: false
    t.text "redirect_uri", null: false
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.string "scopes", limit: 255
    t.index ["application_id"], name: "index_oauth_access_grants_on_application_id"
    t.index ["resource_owner_id"], name: "fk_rails_330c32d8d9"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true
  end

  create_table "oauth_access_tokens", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.integer "resource_owner_id"
    t.integer "application_id"
    t.string "token", limit: 255, null: false
    t.string "refresh_token", limit: 255
    t.integer "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.string "scopes", limit: 255
    t.string "previous_refresh_token", limit: 255, null: false
    t.index ["application_id"], name: "index_oauth_access_tokens_on_application_id"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "uid", limit: 255, null: false
    t.string "secret", limit: 255, null: false
    t.text "redirect_uri", null: false
    t.string "scopes", limit: 255, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "public_pages", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "title", limit: 255
    t.boolean "public"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_public_pages_on_deleted_at"
  end

  create_table "quotes", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.integer "user_id"
    t.integer "reporter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.text "text_ciphertext"
    t.index ["deleted_at"], name: "index_quotes_on_deleted_at"
    t.index ["user_id", "created_at"], name: "index_quotes_on_user_id_and_created_at"
  end

  create_table "recipes", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "name", limit: 255
    t.string "beer", limit: 255
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.integer "beer_id"
    t.integer "user_id"
    t.integer "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date "proefdatum"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_reviews_on_deleted_at"
    t.index ["user_id", "beer_id"], name: "index_reviews_on_user_id_and_beer_id", unique: true
  end

  create_table "signups", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.integer "event_id"
    t.integer "user_id"
    t.boolean "status", default: true
    t.string "reason", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_signups_on_deleted_at"
  end

  create_table "stickers", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "lat", limit: 255
    t.string "lon", limit: 255
    t.text "notes"
    t.text "picture"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.string "image_file_name", limit: 255
    t.string "image_content_type", limit: 255
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.index ["deleted_at"], name: "index_stickers_on_deleted_at"
  end

  create_table "usergroups", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "name", limit: 255
    t.datetime "deleted_at"
    t.string "signal_url"
    t.index ["deleted_at"], name: "index_usergroups_on_deleted_at"
  end

  create_table "users", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "name", limit: 255
    t.string "email", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "remember_token", limit: 255
    t.boolean "admin", default: false
    t.integer "batch"
    t.boolean "anonymous"
    t.datetime "deleted_at"
    t.float "weight", limit: 53, default: 0.0
    t.string "encrypted_password", limit: 255, null: false
    t.string "reset_password_token", limit: 255
    t.string "string", limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "datetime"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip", limit: 255
    t.string "last_sign_in_ip", limit: 255
    t.string "confirmation_token", limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email", limit: 255
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token", limit: 255
    t.datetime "locked_at"
    t.float "sunday_ratio", default: 0.0
    t.string "invitation_token", limit: 255
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type", limit: 255
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.string "phone_number", limit: 255
    t.date "birthday"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by_type_and_invited_by_id"
    t.index ["remember_token"], name: "index_users_on_remember_token"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "versions", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", options: "ENGINE=InnoDB ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.string "event", limit: 255, null: false
    t.string "whodunnit", limit: 255
    t.text "old_object", size: :long
    t.datetime "created_at"
    t.text "old_object_changes", size: :long
    t.json "object"
    t.json "object_changes"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "brews", "recipes"
  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_grants", "users", column: "resource_owner_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "users", column: "resource_owner_id"
end
