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

ActiveRecord::Schema.define(version: 20160218065433) do

  create_table "comments", force: :cascade do |t|
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "text",             limit: 255, null: false
    t.string   "user_name",        limit: 255, null: false
    t.integer  "commentable_id",   limit: 4
    t.string   "commentable_type", limit: 255
    t.integer  "user_id",          limit: 4,   null: false
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "documents", force: :cascade do |t|
    t.integer  "uploader_id", limit: 4
    t.string   "name",        limit: 25,  null: false
    t.string   "attachment",  limit: 255, null: false
    t.string   "description", limit: 125
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "documents", ["uploader_id"], name: "index_documents_on_uploader_id", using: :btree

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.integer  "likable_id",   limit: 4
    t.string   "likable_type", limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "likes", ["user_id", "likable_id", "likable_type"], name: "index_likes_on_user_id_and_likable_id_and_likable_type", using: :btree

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
    t.string   "auth_token",      limit: 255
    t.date     "birth_date",                  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["username"], name: "index_users_on_username", using: :btree

end
