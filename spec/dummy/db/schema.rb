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

ActiveRecord::Schema.define(version: 20130930161545) do

  create_table "activity_items", force: true do |t|
    t.integer  "performer_id"
    t.string   "performer_type"
    t.string   "event"
    t.integer  "target_id"
    t.string   "target_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "topic"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activity_items", ["owner_id", "owner_type", "created_at", "topic"], name: "activity_items_owner_id_type_created_at_topic"
  add_index "activity_items", ["owner_id", "owner_type", "created_at"], name: "index_activity_items_on_owner_id_and_owner_type_and_created_at"

  create_table "connections", force: true do |t|
    t.integer  "subscriber_id"
    t.string   "subscriber_type"
    t.integer  "publisher_id"
    t.string   "publisher_type"
    t.string   "topic"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "connections", ["publisher_id", "publisher_type", "topic"], name: "index_connections_on_publisher_id_and_publisher_type_and_topic", unique: true

  create_table "pages", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "permissions", force: true do |t|
    t.string   "permissor_type"
    t.integer  "permissor_id"
    t.string   "permissible_type"
    t.integer  "permissible_id"
    t.string   "relationship_type", default: "none"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "permissions", ["permissible_type", "permissible_id"], name: "index_permissions_on_permissible_type_and_permissible_id"
  add_index "permissions", ["permissor_type", "permissor_id"], name: "index_permissions_on_permissor_type_and_permissor_id"

  create_table "users", force: true do |t|
    t.string   "nickname"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
