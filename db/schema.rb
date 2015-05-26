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

ActiveRecord::Schema.define(version: 20150525165557) do

  create_table "categories", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "commentable_id",   limit: 4
    t.string   "commentable_type", limit: 255
    t.integer  "commentator_id",   limit: 4
    t.string   "commentator_type", limit: 255
    t.string   "body",             limit: 255
    t.string   "title",            limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "comments", ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id", using: :btree
  add_index "comments", ["commentator_type", "commentator_id"], name: "index_comments_on_commentator_type_and_commentator_id", using: :btree

  create_table "deals", force: :cascade do |t|
    t.string  "title",       limit: 255, null: false
    t.integer "vendor_id",   limit: 4,   null: false
    t.string  "description", limit: 255
  end

  add_index "deals", ["vendor_id"], name: "index_deals_on_vendor_id", using: :btree

  create_table "deals_outlets", id: false, force: :cascade do |t|
    t.integer "deal_id",   limit: 4, null: false
    t.integer "outlet_id", limit: 4, null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",   limit: 4,   null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope",          limit: 255
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "gods", force: :cascade do |t|
    t.string   "provider",               limit: 255,                null: false
    t.string   "uid",                    limit: 255,   default: "", null: false
    t.string   "encrypted_password",     limit: 255,   default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.string   "name",                   limit: 255
    t.string   "nickname",               limit: 255
    t.string   "image",                  limit: 255
    t.string   "email",                  limit: 255
    t.text     "tokens",                 limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "gods", ["email"], name: "index_gods_on_email", using: :btree
  add_index "gods", ["reset_password_token"], name: "index_gods_on_reset_password_token", unique: true, using: :btree
  add_index "gods", ["uid", "provider"], name: "index_gods_on_uid_and_provider", unique: true, using: :btree

  create_table "offer_types", force: :cascade do |t|
    t.string "name",        limit: 255, null: false
    t.string "description", limit: 255
  end

  create_table "offers", force: :cascade do |t|
    t.integer  "deal_id",       limit: 4
    t.integer  "offer_type_id", limit: 4
    t.integer  "discount",      limit: 4
    t.string   "what_you_get",  limit: 255,   null: false
    t.text     "fine_print",    limit: 65535
    t.string   "instruction",   limit: 255
    t.datetime "start_at"
    t.datetime "expire_at"
  end

  add_index "offers", ["deal_id"], name: "index_offers_on_deal_id", using: :btree
  add_index "offers", ["offer_type_id"], name: "index_offers_on_offer_type_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.string   "order_no",     limit: 255
    t.integer  "user_id",      limit: 4
    t.integer  "vendor_id",    limit: 4
    t.integer  "offer_id",     limit: 4
    t.integer  "outlet_id",    limit: 4
    t.string   "what_you_get", limit: 255
    t.text     "fine_print",   limit: 65535
    t.string   "instruction",  limit: 255
    t.datetime "expire_at",                                 null: false
    t.boolean  "redeemed",     limit: 1,     default: true
  end

  add_index "orders", ["offer_id"], name: "index_orders_on_offer_id", using: :btree
  add_index "orders", ["outlet_id"], name: "index_orders_on_outlet_id", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree
  add_index "orders", ["vendor_id"], name: "index_orders_on_vendor_id", using: :btree

  create_table "outlets", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "vendor_id",  limit: 4
    t.decimal  "longitude",              precision: 9, scale: 5
    t.decimal  "latitude",               precision: 9, scale: 5
    t.string   "city",       limit: 255,                         null: false
    t.string   "city_id",    limit: 255,                         null: false
    t.string   "street",     limit: 255,                         null: false
    t.string   "street_id",  limit: 255,                         null: false
    t.string   "address",    limit: 255
    t.string   "email",      limit: 255
    t.string   "slug",       limit: 255
    t.string   "mobile",     limit: 10,                          null: false
    t.string   "contact_no", limit: 11
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  add_index "outlets", ["latitude", "longitude"], name: "index_outlets_on_latitude_and_longitude", using: :btree
  add_index "outlets", ["slug"], name: "index_outlets_on_slug", using: :btree
  add_index "outlets", ["vendor_id"], name: "index_outlets_on_vendor_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "link",       limit: 255
    t.integer  "upvotes",    limit: 4,   default: 0
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "spammable", force: :cascade do |t|
    t.integer  "spammer_id",     limit: 4
    t.string   "spammer_type",   limit: 255
    t.integer  "spammable_id",   limit: 4
    t.string   "spammable_type", limit: 255
    t.string   "reason",         limit: 255, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "spammable", ["spammable_type", "spammable_id"], name: "index_spammable_on_spammable_type_and_spammable_id", using: :btree
  add_index "spammable", ["spammer_type", "spammer_id"], name: "index_spammable_on_spammer_type_and_spammer_id", using: :btree

  create_table "subcategories", force: :cascade do |t|
    t.string  "name",        limit: 255, null: false
    t.integer "category_id", limit: 4,   null: false
  end

  add_index "subcategories", ["category_id"], name: "index_subcategories_on_category_id", using: :btree

  create_table "subcategories_vendors", id: false, force: :cascade do |t|
    t.integer "vendor_id",      limit: 4, null: false
    t.integer "subcategory_id", limit: 4, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider",               limit: 255,                null: false
    t.string   "uid",                    limit: 255,   default: "", null: false
    t.string   "encrypted_password",     limit: 255,   default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.string   "name",                   limit: 255
    t.string   "nickname",               limit: 255
    t.string   "image",                  limit: 255
    t.string   "email",                  limit: 255
    t.text     "tokens",                 limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "mobile",                 limit: 10
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree

  create_table "vendor_images", force: :cascade do |t|
    t.string  "url",       limit: 255, null: false
    t.integer "vendor_id", limit: 4,   null: false
    t.string  "caption",   limit: 255
  end

  add_index "vendor_images", ["vendor_id"], name: "index_vendor_images_on_vendor_id", using: :btree

  create_table "vendors", force: :cascade do |t|
    t.string   "provider",               limit: 255,                null: false
    t.string   "uid",                    limit: 255,   default: "", null: false
    t.string   "encrypted_password",     limit: 255,   default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.string   "name",                   limit: 255
    t.string   "nickname",               limit: 255
    t.string   "image",                  limit: 255
    t.string   "email",                  limit: 255
    t.text     "tokens",                 limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "mobile",                 limit: 10
    t.string   "website",                limit: 255
    t.integer  "category_id",            limit: 4
  end

  add_index "vendors", ["category_id"], name: "index_vendors_on_category_id", using: :btree
  add_index "vendors", ["email"], name: "index_vendors_on_email", using: :btree
  add_index "vendors", ["reset_password_token"], name: "index_vendors_on_reset_password_token", unique: true, using: :btree
  add_index "vendors", ["uid", "provider"], name: "index_vendors_on_uid_and_provider", unique: true, using: :btree

  add_foreign_key "deals", "vendors"
  add_foreign_key "offers", "deals"
  add_foreign_key "offers", "offer_types"
  add_foreign_key "orders", "offers"
  add_foreign_key "orders", "outlets"
  add_foreign_key "orders", "users"
  add_foreign_key "orders", "vendors"
  add_foreign_key "subcategories", "categories"
  add_foreign_key "vendor_images", "vendors"
  add_foreign_key "vendors", "categories"
end
