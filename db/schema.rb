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

ActiveRecord::Schema.define(version: 20150116151531) do

  create_table "campaign_clients", force: :cascade do |t|
    t.integer  "campaign_id", limit: 4
    t.integer  "client_id",   limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "campaign_clients", ["campaign_id"], name: "index_campaign_clients_on_campaign_id", using: :btree
  add_index "campaign_clients", ["client_id"], name: "index_campaign_clients_on_client_id", using: :btree

  create_table "campaigns", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "company",    limit: 255
    t.datetime "start"
    t.datetime "end"
    t.boolean  "hasAll",     limit: 1
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

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
    t.boolean  "isOutside",  limit: 1
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "locations", ["client_id"], name: "index_locations_on_client_id", using: :btree

  create_table "logs", force: :cascade do |t|
    t.string   "macID",            limit: 255
    t.float    "mapX",             limit: 24
    t.float    "mapY",             limit: 24
    t.string   "floor",            limit: 255
    t.datetime "firstLocatedTime"
    t.datetime "lastLocatedTime"
    t.string   "reason",           limit: 255
    t.string   "ip",               limit: 255
    t.string   "username",         limit: 255
    t.string   "dot11status",      limit: 255
    t.boolean  "isGuest",          limit: 1
    t.integer  "location_id",      limit: 4
    t.integer  "client_id",        limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "logs", ["client_id"], name: "index_logs_on_client_id", using: :btree
  add_index "logs", ["location_id"], name: "index_logs_on_location_id", using: :btree

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

  create_table "retentions", force: :cascade do |t|
    t.string   "macID",            limit: 255
    t.integer  "client_id",        limit: 4
    t.datetime "firstLocatedTime"
    t.boolean  "w1",               limit: 1,   default: false
    t.boolean  "w2",               limit: 1,   default: false
    t.boolean  "w3",               limit: 1,   default: false
    t.boolean  "w4",               limit: 1,   default: false
    t.boolean  "w5",               limit: 1,   default: false
    t.boolean  "w6",               limit: 1,   default: false
    t.boolean  "w7",               limit: 1,   default: false
    t.boolean  "w8",               limit: 1,   default: false
    t.boolean  "w9",               limit: 1,   default: false
    t.boolean  "w10",              limit: 1,   default: false
    t.boolean  "w11",              limit: 1,   default: false
    t.boolean  "w12",              limit: 1,   default: false
    t.boolean  "m4",               limit: 1,   default: false
    t.boolean  "m5",               limit: 1,   default: false
    t.boolean  "m6",               limit: 1,   default: false
    t.boolean  "m7",               limit: 1,   default: false
    t.boolean  "m8",               limit: 1,   default: false
    t.boolean  "m9",               limit: 1,   default: false
    t.boolean  "m10",              limit: 1,   default: false
    t.boolean  "m11",              limit: 1,   default: false
    t.boolean  "m12",              limit: 1,   default: false
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  add_index "retentions", ["client_id"], name: "index_retentions_on_client_id", using: :btree

  create_table "session_logs", force: :cascade do |t|
    t.string   "macID",       limit: 255
    t.datetime "logTime"
    t.integer  "client_id",   limit: 4
    t.integer  "duration",    limit: 4,   default: 0
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.datetime "pointer"
    t.boolean  "isClosed",    limit: 1
    t.integer  "location_id", limit: 4
  end

  add_index "session_logs", ["client_id"], name: "index_session_logs_on_client_id", using: :btree
  add_index "session_logs", ["location_id"], name: "index_session_logs_on_location_id", using: :btree

  add_foreign_key "campaign_clients", "campaigns"
  add_foreign_key "campaign_clients", "clients"
  add_foreign_key "locations", "clients"
  add_foreign_key "metrics", "clients"
  add_foreign_key "retentions", "clients"
  add_foreign_key "session_logs", "clients"
  add_foreign_key "session_logs", "locations"
end
