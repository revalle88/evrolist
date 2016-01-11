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

ActiveRecord::Schema.define(version: 20151208114718) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "article_products", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "article_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "article_products", ["article_id"], name: "index_article_products_on_article_id", using: :btree
  add_index "article_products", ["product_id"], name: "index_article_products_on_product_id", using: :btree

  create_table "articles", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.text     "description"
    t.boolean  "isNew"
    t.boolean  "isReview"
    t.boolean  "onHomePage"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.string   "id1c"
    t.integer  "parent_id"
    t.integer  "lft",                            null: false
    t.integer  "rgt",                            null: false
    t.integer  "depth",              default: 0, null: false
    t.integer  "children_count",     default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "categories", ["lft"], name: "index_categories_on_lft", using: :btree
  add_index "categories", ["parent_id"], name: "index_categories_on_parent_id", using: :btree
  add_index "categories", ["rgt"], name: "index_categories_on_rgt", using: :btree

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "order_items", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "order_id"
    t.decimal  "unit_price",  precision: 12, scale: 3
    t.integer  "quantity"
    t.decimal  "total_price", precision: 12, scale: 3
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id", using: :btree
  add_index "order_items", ["product_id"], name: "index_order_items_on_product_id", using: :btree

  create_table "order_statuses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: :cascade do |t|
    t.decimal  "subtotal",        precision: 12, scale: 3
    t.decimal  "tax",             precision: 12, scale: 3
    t.decimal  "shipping",        precision: 12, scale: 3
    t.decimal  "total",           precision: 12, scale: 3
    t.integer  "order_status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["order_status_id"], name: "index_orders_on_order_status_id", using: :btree

  create_table "product_properties", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "property_id"
    t.string   "stringValue"
    t.float    "floatValue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "product_properties", ["product_id"], name: "index_product_properties_on_product_id", using: :btree
  add_index "product_properties", ["property_id"], name: "index_product_properties_on_property_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.string   "id1c"
    t.text     "descriptionFull"
    t.text     "descriptionMin"
    t.string   "articul"
    t.string   "baseUnit"
    t.string   "shtrihkod"
    t.string   "standart"
    t.decimal  "price"
    t.float    "rest"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id", using: :btree

  create_table "properties", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "phoneWork"
    t.string   "phoneMob"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.boolean  "admin"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
