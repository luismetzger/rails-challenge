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

ActiveRecord::Schema.define(version: 2019_06_19_182245) do

  create_table "collections", force: :cascade do |t|
    t.string "name"
    t.string "type"
  end

  create_table "collections_products", id: false, force: :cascade do |t|
    t.integer "product_id"
    t.integer "collection_id"
    t.index ["collection_id"], name: "index_collections_products_on_collection_id"
    t.index ["product_id"], name: "index_collections_products_on_product_id"
  end

  create_table "customer_orders", force: :cascade do |t|
    t.integer "total_cost"
    t.integer "order_status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "customer_id"
    t.index ["customer_id"], name: "index_customer_orders_on_customer_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "email"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
  end

  create_table "variant_orders", force: :cascade do |t|
    t.integer "variant_id"
    t.integer "variant_quantity"
    t.integer "customer_order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_order_id"], name: "index_variant_orders_on_customer_order_id"
    t.index ["variant_id"], name: "index_variant_orders_on_variant_id"
  end

  create_table "variants", force: :cascade do |t|
    t.string "name"
    t.integer "cost"
    t.integer "stock_amount"
    t.float "weight"
    t.integer "product_id"
    t.index ["product_id"], name: "index_variants_on_product_id"
  end

end
