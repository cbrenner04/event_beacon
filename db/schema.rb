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

ActiveRecord::Schema.define(version: 20180905033611) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contacts", force: :cascade do |t|
    t.string "subject", null: false
    t.text "body", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_contacts_on_user_id"
  end

  create_table "data_encryption_keys", force: :cascade do |t|
    t.string "encrypted_key", null: false
    t.string "encrypted_key_iv"
    t.boolean "primary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "encrypted_fields", force: :cascade do |t|
    t.string "encrypted_blob", null: false
    t.string "encrypted_blob_iv"
    t.bigint "data_encryption_key_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["data_encryption_key_id"], name: "index_encrypted_fields_on_data_encryption_key_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "occurs_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "experiences", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "occurs_at", null: false
    t.bigint "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "notification_offset", default: 30, null: false
    t.index ["event_id"], name: "index_experiences_on_event_id"
  end

  create_table "guests", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.integer "notification_category"
    t.bigint "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "email_encrypted_field_id"
    t.integer "phone_number_encrypted_field_id"
    t.index ["event_id"], name: "index_guests_on_event_id"
  end

  create_table "guests_notifications", force: :cascade do |t|
    t.integer "guest_id", null: false
    t.integer "notification_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["guest_id", "notification_id"], name: "index_guests_notifications_on_guest_id_and_notification_id", unique: true
    t.index ["guest_id"], name: "index_guests_notifications_on_guest_id"
    t.index ["notification_id"], name: "index_guests_notifications_on_notification_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.text "sms_body", null: false
    t.text "email_body", null: false
    t.bigint "experience_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["experience_id"], name: "index_notifications_on_experience_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "unconfirmed_email"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_events", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_users_events_on_event_id"
    t.index ["user_id", "event_id"], name: "index_users_events_on_user_id_and_event_id", unique: true
    t.index ["user_id"], name: "index_users_events_on_user_id"
  end

  add_foreign_key "contacts", "users"
  add_foreign_key "encrypted_fields", "data_encryption_keys"
  add_foreign_key "experiences", "events"
  add_foreign_key "guests", "events"
  add_foreign_key "notifications", "experiences"
end
