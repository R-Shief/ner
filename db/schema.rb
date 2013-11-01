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

ActiveRecord::Schema.define(version: 20131101125426) do

  create_table "category", primary_key: "cat_id", force: true do |t|
    t.binary  "cat_title",   limit: 255,                 null: false
    t.integer "cat_pages",               default: 0,     null: false
    t.integer "cat_subcats",             default: 0,     null: false
    t.integer "cat_files",               default: 0,     null: false
    t.boolean "cat_hidden",              default: false, null: false
  end

  add_index "category", ["cat_pages"], name: "cat_pages", using: :btree
  add_index "category", ["cat_title"], name: "cat_title", unique: true, using: :btree

  create_table "categorylinks", id: false, force: true do |t|
    t.integer   "cl_from",                       default: 0,      null: false
    t.binary    "cl_to",             limit: 255,                  null: false
    t.binary    "cl_sortkey",        limit: 230,                  null: false
    t.timestamp "cl_timestamp",                                   null: false
    t.binary    "cl_sortkey_prefix", limit: 255,                  null: false
    t.binary    "cl_collation",      limit: 32,                   null: false
    t.string    "cl_type",           limit: 6,   default: "page", null: false
  end

  add_index "categorylinks", ["cl_collation"], name: "cl_collation", using: :btree
  add_index "categorylinks", ["cl_from", "cl_to"], name: "cl_from", unique: true, using: :btree
  add_index "categorylinks", ["cl_to", "cl_timestamp"], name: "cl_timestamp", using: :btree
  add_index "categorylinks", ["cl_to", "cl_type", "cl_sortkey", "cl_from"], name: "cl_sortkey", using: :btree

  create_table "externallinks", id: false, force: true do |t|
    t.integer "el_from",  default: 0, null: false
    t.binary  "el_to",                null: false
    t.binary  "el_index",             null: false
  end

  add_index "externallinks", ["el_from", "el_to"], name: "el_from", length: {"el_from"=>nil, "el_to"=>40}, using: :btree
  add_index "externallinks", ["el_index"], name: "el_index", length: {"el_index"=>60}, using: :btree
  add_index "externallinks", ["el_to", "el_from"], name: "el_to", length: {"el_to"=>60, "el_from"=>nil}, using: :btree

  create_table "page_texts", force: true do |t|
    t.integer  "page_id"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "html"
  end

  add_index "page_texts", ["page_id"], name: "index_page_texts_on_page_id", using: :btree

  create_table "pagelinks", id: false, force: true do |t|
    t.integer "pl_from",                  default: 0, null: false
    t.integer "pl_namespace",             default: 0, null: false
    t.binary  "pl_title",     limit: 255,             null: false
  end

  add_index "pagelinks", ["pl_from", "pl_namespace", "pl_title"], name: "pl_from", unique: true, using: :btree
  add_index "pagelinks", ["pl_namespace", "pl_title", "pl_from"], name: "pl_namespace", using: :btree

  create_table "redirect", primary_key: "rd_from", force: true do |t|
    t.integer "rd_namespace",             default: 0, null: false
    t.binary  "rd_title",     limit: 255,             null: false
    t.binary  "rd_interwiki", limit: 32
    t.binary  "rd_fragment",  limit: 255
  end

  add_index "redirect", ["rd_namespace", "rd_title", "rd_from"], name: "rd_ns_title", using: :btree

  create_table "site_stats", id: false, force: true do |t|
    t.integer "ss_row_id",                  default: 0,  null: false
    t.integer "ss_total_views",   limit: 8, default: 0
    t.integer "ss_total_edits",   limit: 8, default: 0
    t.integer "ss_good_articles", limit: 8, default: 0
    t.integer "ss_total_pages",   limit: 8, default: -1
    t.integer "ss_users",         limit: 8, default: -1
    t.integer "ss_images",                  default: 0
    t.integer "ss_active_users",  limit: 8, default: -1
  end

  add_index "site_stats", ["ss_row_id"], name: "ss_row_id", unique: true, using: :btree

end
