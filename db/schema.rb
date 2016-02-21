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

ActiveRecord::Schema.define(version: 20160221203022) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "periods", force: :cascade do |t|
    t.datetime "time_from"
    t.datetime "time_to"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "places", force: :cascade do |t|
    t.string   "name"
    t.string   "map_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reservations", force: :cascade do |t|
    t.datetime "time_from"
    t.datetime "time_to"
    t.decimal  "money"
    t.integer  "capacity"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "place_id"
    t.integer  "user_id"
    t.integer  "category_id"
  end

  create_table "reservations_users", id: false, force: :cascade do |t|
    t.integer  "reservation_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reservations_users", ["reservation_id", "user_id"], name: "index_reservations_users_on_reservation_id_and_user_id", unique: true, using: :btree

  create_table "training_categories", force: :cascade do |t|
    t.string   "name"
    t.float    "koef"
    t.integer  "minimum"
    t.text     "description"
    t.string   "units"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "image"
    t.float    "points"
  end

  create_table "trainings", force: :cascade do |t|
    t.integer  "training_category_id"
    t.float    "points"
    t.text     "description"
    t.float    "distance"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "user_id"
    t.integer  "period_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "surname"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",           default: false
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
  end

  create_table "workouts", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_foreign_key "reservations_users", "reservations"
  add_foreign_key "reservations_users", "users"
  add_foreign_key "trainings", "periods"
  add_foreign_key "trainings", "training_categories"
  add_foreign_key "trainings", "users"
end
