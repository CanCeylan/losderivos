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

ActiveRecord::Schema.define(version: 20150113085823) do

  create_table "clients", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "branch",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "locations", force: :cascade do |t|
    t.integer  "client_id",  limit: 4
    t.string   "region",     limit: 255
    t.float    "minX",       limit: 24
    t.float    "maxX",       limit: 24
    t.float    "minY",       limit: 24
    t.float    "maxY",       limit: 24
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "locations", ["client_id"], name: "index_locations_on_client_id", using: :btree

  create_table "logs", force: :cascade do |t|
    t.string   "macID",            limit: 255
    t.float    "mapX",             limit: 24
    t.float    "mapY",             limit: 24
    t.string   "hierarchy",        limit: 255
    t.string   "floor",            limit: 255
    t.datetime "firstLocatedTime"
    t.datetime "lastLocatedTime"
    t.string   "reason",           limit: 255
    t.string   "ip",               limit: 255
    t.string   "username",         limit: 255
    t.string   "dot11status",      limit: 255
    t.boolean  "isGuest",          limit: 1
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "metrics", force: :cascade do |t|
    t.date     "logDate"
    t.integer  "client_id",          limit: 4
    t.integer  "potential",          limit: 4
    t.integer  "conversion",         limit: 4
    t.integer  "newCustomers",       limit: 4
    t.integer  "repeatCustomers",    limit: 4
    t.integer  "averageTime",        limit: 4
    t.integer  "bounce",             limit: 4
    t.float    "weeklyRetention",    limit: 24
    t.float    "monthlyRetention",   limit: 24
    t.float    "biMonthlyRetention", limit: 24
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "metrics", ["client_id"], name: "index_metrics_on_client_id", using: :btree

  create_table "session_logs", force: :cascade do |t|
    t.string   "macID",      limit: 255
    t.datetime "logTime"
    t.integer  "client_id",  limit: 4
    t.integer  "duration",   limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "session_logs", ["client_id"], name: "index_session_logs_on_client_id", using: :btree

  add_foreign_key "locations", "clients"
  add_foreign_key "metrics", "clients"
  add_foreign_key "session_logs", "clients"
end
