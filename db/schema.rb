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

ActiveRecord::Schema.define(version: 20160215183726) do

  create_table "documents", force: :cascade do |t|
    t.integer  "uploader_id", limit: 4
    t.string   "name",        limit: 25,  null: false
    t.string   "attachment",  limit: 255, null: false
    t.string   "description", limit: 125
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "documents", ["uploader_id"], name: "index_documents_on_uploader_id", using: :btree

  create_table "pages", force: :cascade do |t|
    t.integer  "document_id", limit: 4
    t.integer  "position",    limit: 4, null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "pages", ["document_id"], name: "index_pages_on_document_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username",        limit: 25
    t.string   "first_name",      limit: 50
    t.string   "last_name",       limit: 50
    t.string   "email",           limit: 50,  null: false
    t.string   "password_digest", limit: 255, null: false
    t.date     "birth_date",                  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["username"], name: "index_users_on_username", using: :btree

end
