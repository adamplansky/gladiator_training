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

ActiveRecord::Schema.define(version: 20170328153044) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "challenge_scores", force: :cascade do |t|
    t.string   "url"
    t.integer  "user_id"
    t.integer  "challenge_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "gym_id"
    t.integer  "challenge_time"
  end

  add_index "challenge_scores", ["challenge_id"], name: "index_challenge_scores_on_challenge_id", using: :btree
  add_index "challenge_scores", ["gym_id"], name: "index_challenge_scores_on_gym_id", using: :btree
  add_index "challenge_scores", ["user_id"], name: "index_challenge_scores_on_user_id", using: :btree

  create_table "challenges", force: :cascade do |t|
    t.string   "url"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "from_time"
    t.datetime "to_time"
    t.integer  "season_id"
  end

  add_index "challenges", ["season_id"], name: "index_challenges_on_season_id", using: :btree

  create_table "dictionaries", force: :cascade do |t|
    t.string   "en_name"
    t.string   "cz_name"
    t.string   "abr"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "event_users", force: :cascade do |t|
    t.boolean  "payed"
    t.datetime "registration_time"
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "event_users", ["event_id"], name: "index_event_users_on_event_id", using: :btree
  add_index "event_users", ["user_id"], name: "index_event_users_on_user_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.datetime "event_date"
    t.datetime "registration_end"
    t.string   "url"
    t.string   "image"
    t.text     "description"
    t.decimal  "min_money"
    t.text     "contact"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "place"
    t.string   "place_url"
    t.string   "contact_url"
  end

  create_table "gyms", force: :cascade do |t|
    t.string   "name"
    t.string   "image"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "description"
    t.text     "web"
  end

  create_table "links", force: :cascade do |t|
    t.string   "title"
    t.string   "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "periods", force: :cascade do |t|
    t.datetime "time_from"
    t.datetime "time_to"
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "time_from_1"
    t.datetime "time_to_1"
    t.datetime "time_from_2"
    t.datetime "time_to_2"
    t.datetime "time_from_3"
    t.datetime "time_to_3"
  end

  create_table "pgdbs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "places", force: :cascade do |t|
    t.string   "name"
    t.string   "map_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reacttests", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "registrations", force: :cascade do |t|
    t.boolean  "payed",             default: false
    t.datetime "registration_time"
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "registrations", ["event_id"], name: "index_registrations_on_event_id", using: :btree
  add_index "registrations", ["user_id", "event_id"], name: "index_registrations_on_user_id_and_event_id", unique: true, using: :btree
  add_index "registrations", ["user_id"], name: "index_registrations_on_user_id", using: :btree

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

  create_table "seasons", force: :cascade do |t|
    t.datetime "from_time"
    t.datetime "to_time"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.string   "logo_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

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

  create_table "user_teams", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "team_id"
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
    t.integer  "gym_id"
    t.integer  "gender"
    t.string   "image"
  end

  add_foreign_key "challenge_scores", "challenges"
  add_foreign_key "challenge_scores", "gyms"
  add_foreign_key "challenge_scores", "users"
  add_foreign_key "challenges", "seasons"
  add_foreign_key "event_users", "events"
  add_foreign_key "event_users", "users"
  add_foreign_key "registrations", "events"
  add_foreign_key "registrations", "users"
  add_foreign_key "reservations_users", "reservations"
  add_foreign_key "reservations_users", "users"
  add_foreign_key "trainings", "periods"
  add_foreign_key "trainings", "training_categories"
  add_foreign_key "trainings", "users"
end
