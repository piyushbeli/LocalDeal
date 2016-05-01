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

ActiveRecord::Schema.define(version: 20160418115605) do

  create_table "average_caches", force: :cascade do |t|
    t.integer  "rater_id",      limit: 4
    t.integer  "rateable_id",   limit: 4
    t.string   "rateable_type", limit: 255
    t.float    "avg",           limit: 24,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "slug", limit: 255, null: false
  end

  add_index "categories", ["slug"], name: "index_categories_on_slug", using: :btree

  create_table "comments", force: :cascade do |t|
    t.integer  "commentable_id",   limit: 4
    t.string   "commentable_type", limit: 255
    t.integer  "commentator_id",   limit: 4
    t.string   "commentator_type", limit: 255
    t.integer  "offer_id",         limit: 4
    t.string   "body",             limit: 255
    t.string   "title",            limit: 255
    t.integer  "no_of_comments",   limit: 4,   default: 0
    t.integer  "no_of_likes",      limit: 4,   default: 0
    t.integer  "no_of_spams",      limit: 4,   default: 0
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "comments", ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id", using: :btree
  add_index "comments", ["commentator_type", "commentator_id"], name: "index_comments_on_commentator_type_and_commentator_id", using: :btree
  add_index "comments", ["offer_id"], name: "index_comments_on_offer_id", using: :btree

  create_table "company_settings", force: :cascade do |t|
    t.string "terms_and_conditions_vendor", limit: 255
    t.string "terms_and_conditions_user",   limit: 255
    t.string "about_us",                    limit: 255
    t.string "contact_us",                  limit: 255
  end

  create_table "deals", force: :cascade do |t|
    t.string  "title",       limit: 255, null: false
    t.integer "vendor_id",   limit: 4,   null: false
    t.string  "description", limit: 255
    t.string  "slug",        limit: 255, null: false
  end

  add_index "deals", ["slug"], name: "index_deals_on_slug", using: :btree
  add_index "deals", ["vendor_id"], name: "index_deals_on_vendor_id", using: :btree

  create_table "deals_outlets", id: false, force: :cascade do |t|
    t.integer "deal_id",   limit: 4, null: false
    t.integer "outlet_id", limit: 4, null: false
  end

  add_index "deals_outlets", ["deal_id", "outlet_id"], name: "by_deal_and_outlet", unique: true, using: :btree

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

  create_table "marks", force: :cascade do |t|
    t.integer  "marker_id",     limit: 4
    t.string   "marker_type",   limit: 255
    t.integer  "markable_id",   limit: 4
    t.string   "markable_type", limit: 255
    t.string   "mark",          limit: 128
    t.datetime "created_at"
  end

  add_index "marks", ["markable_id", "markable_type", "mark"], name: "index_marks_on_markable_id_and_markable_type_and_mark", using: :btree
  add_index "marks", ["marker_id", "marker_type", "mark"], name: "index_marks_on_marker_id_and_marker_type_and_mark", using: :btree

  create_table "myfilters", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.text     "criteria",   limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "myfilters", ["user_id"], name: "index_myfilters_on_user_id", using: :btree

  create_table "offer_types", force: :cascade do |t|
    t.string "name",        limit: 255, null: false
    t.string "description", limit: 255
  end

  create_table "offers", force: :cascade do |t|
    t.integer  "deal_id",           limit: 4
    t.integer  "offer_type_id",     limit: 4
    t.integer  "discount",          limit: 4
    t.integer  "actual_price",      limit: 4
    t.string   "what_you_get",      limit: 255,   null: false
    t.text     "fine_print",        limit: 65535
    t.string   "instruction",       limit: 255
    t.integer  "max_no_of_coupons", limit: 4,     null: false
    t.datetime "start_at",                        null: false
    t.datetime "end_at",                          null: false
    t.datetime "expire_at",                       null: false
    t.integer  "offered_price",     limit: 4
  end

  add_index "offers", ["deal_id"], name: "index_offers_on_deal_id", using: :btree
  add_index "offers", ["end_at"], name: "index_offers_on_end_at", using: :btree
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
    t.datetime "created_at",                                null: false
    t.boolean  "redeemed",     limit: 1,     default: true
  end

  add_index "orders", ["offer_id"], name: "index_orders_on_offer_id", using: :btree
  add_index "orders", ["outlet_id"], name: "index_orders_on_outlet_id", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree
  add_index "orders", ["vendor_id"], name: "index_orders_on_vendor_id", using: :btree

  create_table "outlet_images", force: :cascade do |t|
    t.string   "url",           limit: 255, null: false
    t.integer  "outlet_id",     limit: 4,   null: false
    t.integer  "uploader_id",   limit: 4,   null: false
    t.string   "uploader_type", limit: 255, null: false
    t.integer  "comment_id",    limit: 4
    t.integer  "offer_id",      limit: 4
    t.string   "caption",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "outlet_images", ["comment_id"], name: "index_outlet_images_on_comment_id", using: :btree
  add_index "outlet_images", ["offer_id"], name: "index_outlet_images_on_offer_id", using: :btree
  add_index "outlet_images", ["outlet_id"], name: "index_outlet_images_on_outlet_id", using: :btree
  add_index "outlet_images", ["uploader_type", "uploader_id"], name: "index_outlet_images_on_uploader_type_and_uploader_id", using: :btree

  create_table "outlet_menus", force: :cascade do |t|
    t.string   "url",        limit: 255, null: false
    t.integer  "outlet_id",  limit: 4,   null: false
    t.string   "caption",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "outlet_menus", ["outlet_id"], name: "index_outlet_menus_on_outlet_id", using: :btree

  create_table "outlets", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.integer  "vendor_id",        limit: 4
    t.decimal  "longitude",                    precision: 9, scale: 5
    t.decimal  "latitude",                     precision: 9, scale: 5
    t.string   "city",             limit: 255,                         null: false
    t.decimal  "city_latitude",                precision: 9, scale: 5
    t.decimal  "city_longitude",               precision: 9, scale: 5
    t.string   "city_id",          limit: 255,                         null: false
    t.string   "street",           limit: 255,                         null: false
    t.string   "street_id",        limit: 255,                         null: false
    t.decimal  "street_latitude",              precision: 9, scale: 5
    t.decimal  "street_longitude",             precision: 9, scale: 5
    t.string   "address",          limit: 255
    t.string   "email",            limit: 255
    t.string   "slug",             limit: 255,                         null: false
    t.string   "mobile",           limit: 10,                          null: false
    t.string   "contact_no",       limit: 11
    t.integer  "no_of_followers",  limit: 4
    t.integer  "no_of_comments",   limit: 4
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
  end

  add_index "outlets", ["latitude", "longitude"], name: "index_outlets_on_latitude_and_longitude", using: :btree
  add_index "outlets", ["slug"], name: "index_outlets_on_slug", unique: true, using: :btree
  add_index "outlets", ["vendor_id"], name: "index_outlets_on_vendor_id", using: :btree

  create_table "overall_averages", force: :cascade do |t|
    t.integer  "rateable_id",   limit: 4
    t.string   "rateable_type", limit: 255
    t.float    "overall_avg",   limit: 24,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "link",       limit: 255
    t.integer  "upvotes",    limit: 4,   default: 0
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "rates", force: :cascade do |t|
    t.integer  "rater_id",      limit: 4
    t.integer  "rateable_id",   limit: 4
    t.string   "rateable_type", limit: 255
    t.float    "stars",         limit: 24,  null: false
    t.string   "dimension",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rates", ["rateable_id", "rateable_type"], name: "index_rates_on_rateable_id_and_rateable_type", using: :btree
  add_index "rates", ["rater_id"], name: "index_rates_on_rater_id", using: :btree

  create_table "rating_caches", force: :cascade do |t|
    t.integer  "cacheable_id",   limit: 4
    t.string   "cacheable_type", limit: 255
    t.float    "avg",            limit: 24,  null: false
    t.integer  "qty",            limit: 4,   null: false
    t.string   "dimension",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rating_caches", ["cacheable_id", "cacheable_type"], name: "index_rating_caches_on_cacheable_id_and_cacheable_type", using: :btree

  create_table "spams", force: :cascade do |t|
    t.integer  "spammer_id",     limit: 4
    t.string   "spammer_type",   limit: 255
    t.integer  "spammable_id",   limit: 4
    t.string   "spammable_type", limit: 255
    t.string   "reason",         limit: 255, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "spams", ["spammable_type", "spammable_id"], name: "index_spams_on_spammable_type_and_spammable_id", using: :btree
  add_index "spams", ["spammer_type", "spammer_id"], name: "index_spams_on_spammer_type_and_spammer_id", using: :btree

  create_table "subcategories", force: :cascade do |t|
    t.string  "name",        limit: 255, null: false
    t.integer "category_id", limit: 4,   null: false
    t.string  "slug",        limit: 255, null: false
  end

  add_index "subcategories", ["category_id"], name: "index_subcategories_on_category_id", using: :btree
  add_index "subcategories", ["slug"], name: "index_subcategories_on_slug", using: :btree

  create_table "subcategories_vendors", id: false, force: :cascade do |t|
    t.integer "vendor_id",      limit: 4, null: false
    t.integer "subcategory_id", limit: 4, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider",               limit: 255,                        null: false
    t.string   "uid",                    limit: 255,   default: "",         null: false
    t.string   "encrypted_password",     limit: 255,   default: "",         null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,          null: false
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
    t.string   "city_id",                limit: 255
    t.string   "city",                   limit: 255
    t.boolean  "is_verified",            limit: 1,     default: false,      null: false
    t.integer  "no_of_comments",         limit: 4
    t.integer  "no_of_followings",       limit: 4
    t.integer  "no_of_followers",        limit: 4
    t.integer  "no_of_favorite_outlets", limit: 4
    t.string   "slug",                   limit: 255
    t.string   "badge",                  limit: 255,   default: "beginner"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree

  create_table "vendors", force: :cascade do |t|
    t.string   "provider",               limit: 255,                   null: false
    t.string   "uid",                    limit: 255,   default: "",    null: false
    t.string   "encrypted_password",     limit: 255,   default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,     null: false
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
    t.boolean  "is_verified",            limit: 1,     default: false, null: false
    t.string   "about_me",               limit: 255
    t.string   "slug",                   limit: 255
    t.integer  "category_id",            limit: 4
    t.string   "fb_page",                limit: 255
    t.string   "google_plus_page",       limit: 255
    t.string   "twitter_page",           limit: 255
    t.string   "instagram_page",         limit: 255
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
  add_foreign_key "vendors", "categories"
end
