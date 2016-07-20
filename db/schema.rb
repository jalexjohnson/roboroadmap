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

ActiveRecord::Schema.define(version: 0) do

  create_table "bidders", force: :cascade do |t|
    t.integer  "allowance"
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bidders", ["project_id"], name: "index_bidders_on_project_id"
  add_index "bidders", ["user_id"], name: "index_bidders_on_user_id"

  create_table "bids", force: :cascade do |t|
    t.integer  "amount"
    t.integer  "bidder_id"
    t.integer  "job_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bids", ["bidder_id"], name: "index_bids_on_bidder_id"
  add_index "bids", ["job_id"], name: "index_bids_on_job_id"

  create_table "jobs", force: :cascade do |t|
    t.string   "name"
    t.integer  "size",        default: 0
    t.integer  "total_value", default: 0
    t.text     "description"
    t.boolean  "fits",        default: false
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "jobs", ["project_id"], name: "index_jobs_on_project_id"

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.integer  "capacity",    default: 0
    t.datetime "auction_end"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects", ["user_id"], name: "index_projects_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "admin",           default: false
    t.boolean  "permitted",       default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
