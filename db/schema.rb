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

ActiveRecord::Schema.define(version: 2020_06_08_063206) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "favorite_product_deals", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "product_deal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_deal_id", "user_id"], name: "index_favorite_product_deals_on_product_deal_id_and_user_id", unique: true
    t.index ["product_deal_id"], name: "index_favorite_product_deals_on_product_deal_id"
    t.index ["user_id"], name: "index_favorite_product_deals_on_user_id"
  end

  create_table "jwt_blacklist", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["jti"], name: "index_jwt_blacklist_on_jti"
  end

  create_table "product_deals", force: :cascade do |t|
    t.string "title", null: false
    t.text "description", null: false
    t.bigint "user_id"
    t.datetime "exp_date", null: false
    t.string "img_url", null: false
    t.float "new_price", null: false
    t.string "product_type", null: false
    t.float "original_price", null: false
    t.string "web_link", null: false
    t.string "manufacturer", null: false
    t.integer "favorited_count", default: 0
    t.boolean "redeemed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["favorited_count"], name: "index_product_deals_on_favorited_count"
    t.index ["user_id"], name: "index_product_deals_on_user_id"
  end

  create_table "user_comments", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "product_deal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "body", null: false
    t.index ["product_deal_id"], name: "index_user_comments_on_product_deal_id"
    t.index ["user_id"], name: "index_user_comments_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "favorite_product_deals", "product_deals"
  add_foreign_key "favorite_product_deals", "users"
  add_foreign_key "product_deals", "users"
  add_foreign_key "user_comments", "product_deals"
  add_foreign_key "user_comments", "users"
end
