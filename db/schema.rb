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

ActiveRecord::Schema.define(version: 20171008151228) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentication_tokens", force: :cascade do |t|
    t.string "body"
    t.bigint "user_id"
    t.datetime "last_used_at"
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_authentication_tokens_on_user_id"
  end

  create_table "mtg_card_types", id: :serial, force: :cascade do |t|
    t.integer "mtg_card_id"
    t.integer "mtg_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mtg_cards", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "gatherer_url"
    t.string "multiverse_id"
    t.string "gatherer_image_url"
    t.string "mana_cost"
    t.string "converted_cost"
    t.text "oracle_text"
    t.text "flavor_text"
    t.string "mark"
    t.string "power"
    t.string "toughness"
    t.string "loyalty"
    t.string "rarity"
    t.string "transformed_id"
    t.string "colors"
    t.string "artist"
    t.integer "mtg_set_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "card_number"
  end

  create_table "mtg_sets", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mtg_types", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "records", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "status"
    t.string "s3_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "analysis_data", default: "null"
    t.datetime "analyzed_at"
    t.string "plate"
    t.json "location"
    t.index ["user_id"], name: "index_records_on_user_id"
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
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "authentication_tokens", "users"
end
