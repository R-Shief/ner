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

ActiveRecord::Schema.define(version: 20131103232127) do

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

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

  create_table "page", primary_key: "page_id", force: true do |t|
    t.integer "page_namespace",                    default: 0,     null: false
    t.binary  "page_title",            limit: 255,                 null: false
    t.binary  "page_restrictions",     limit: 255,                 null: false
    t.integer "page_counter",          limit: 8,   default: 0,     null: false
    t.boolean "page_is_redirect",                  default: false, null: false
    t.boolean "page_is_new",                       default: false, null: false
    t.float   "page_random",                       default: 0.0,   null: false
    t.binary  "page_touched",          limit: 14,                  null: false
    t.integer "page_latest",                       default: 0,     null: false
    t.integer "page_len",                          default: 0,     null: false
    t.boolean "page_no_title_convert",             default: false, null: false
    t.binary  "html"
    t.binary  "title",                 limit: 255
  end

  add_index "page", ["page_is_redirect", "page_namespace", "page_len"], name: "page_redirect_namespace_len", using: :btree
  add_index "page", ["page_len"], name: "page_len", using: :btree
  add_index "page", ["page_namespace", "page_title"], name: "name_title", unique: true, using: :btree
  add_index "page", ["page_random"], name: "page_random", using: :btree

  create_table "page_texts", force: true do |t|
    t.integer  "page_id"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "html"
    t.string   "title"
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
