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

ActiveRecord::Schema[7.2].define(version: 2026_01_05_201638) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "boards", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "address"
    t.string "nearest_station"
    t.text "opening_hours"
    t.integer "coffe_price"
    t.integer "seat_count"
    t.integer "smorking_policy"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_boards_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "board_id", null: false
    t.integer "workability_rating"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_reviews_on_board_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "nickname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "crypted_password"
    t.string "salt"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "boards", "users"
  add_foreign_key "reviews", "boards"
  add_foreign_key "reviews", "users"
end
