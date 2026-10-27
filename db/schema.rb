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

ActiveRecord::Schema[8.1].define(version: 2026_10_27_120000) do
  create_table "articles", force: :cascade do |t|
    t.text "body"
    t.string "category"
    t.datetime "created_at", null: false
    t.string "summary"
    t.string "title", null: false
    t.datetime "updated_at", null: false
  end

  create_table "applications", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "listing_id", null: false
    t.text "message"
    t.string "status"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["listing_id"], name: "index_applications_on_listing_id"
    t.index ["user_id"], name: "index_applications_on_user_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "listing_id", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["listing_id"], name: "index_favorites_on_listing_id"
    t.index ["user_id", "listing_id"], name: "index_favorites_on_user_id_and_listing_id", unique: true
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "listings", force: :cascade do |t|
    t.date "active_until"
    t.string "city"
    t.datetime "created_at", null: false
    t.text "description"
    t.integer "max_people"
    t.integer "rent"
    t.integer "rooms"
    t.string "status", default: "active", null: false
    t.string "title"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_listings_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.boolean "read", default: false, null: false
    t.text "text"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "preferences", force: :cascade do |t|
    t.string "alcohol"
    t.integer "budget"
    t.string "cleanliness"
    t.datetime "created_at", null: false
    t.string "guests"
    t.string "noise"
    t.boolean "pets", default: false, null: false
    t.boolean "remote_work", default: false, null: false
    t.string "schedule"
    t.boolean "shared_food", default: false, null: false
    t.boolean "smoking", default: false, null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_preferences_on_user_id", unique: true
  end

  create_table "reports", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.integer "listing_id", null: false
    t.string "reason"
    t.string "status", default: "new", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["listing_id"], name: "index_reports_on_listing_id"
    t.index ["user_id"], name: "index_reports_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "author_id", null: false
    t.datetime "created_at", null: false
    t.integer "rating"
    t.integer "recipient_id", null: false
    t.text "text"
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_reviews_on_author_id"
    t.index ["recipient_id"], name: "index_reviews_on_recipient_id"
  end

  create_table "tags", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "listing_id", null: false
    t.string "name"
    t.datetime "updated_at", null: false
    t.index ["listing_id"], name: "index_tags_on_listing_id"
  end

  create_table "users", force: :cascade do |t|
    t.text "about"
    t.boolean "admin", default: false, null: false
    t.integer "age"
    t.integer "budget"
    t.string "city"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.string "occupation"
    t.string "password_digest"
    t.decimal "rating", precision: 2, scale: 1, default: "0.0"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "applications", "listings"
  add_foreign_key "applications", "users"
  add_foreign_key "favorites", "listings"
  add_foreign_key "favorites", "users"
  add_foreign_key "listings", "users"
  add_foreign_key "notifications", "users"
  add_foreign_key "preferences", "users"
  add_foreign_key "reports", "listings"
  add_foreign_key "reports", "users"
  add_foreign_key "reviews", "users", column: "author_id"
  add_foreign_key "reviews", "users", column: "recipient_id"
  add_foreign_key "tags", "listings"
end
