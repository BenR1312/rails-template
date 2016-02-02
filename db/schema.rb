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

ActiveRecord::Schema.define(version: 20160202051047) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string   "line_1",     null: false
    t.string   "line_2"
    t.string   "city"
    t.integer  "state_id",   null: false
    t.string   "post_code",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.string   "country"
    t.text     "slogan"
    t.string   "banner_image"
    t.string   "logo"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.datetime "deleted_at"
  end

  create_table "fleet_trucks", force: :cascade do |t|
    t.integer  "fleet_id"
    t.integer  "truck_id"
    t.string   "status",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "fleet_trucks", ["fleet_id"], name: "index_fleet_trucks_on_fleet_id", using: :btree
  add_index "fleet_trucks", ["truck_id"], name: "index_fleet_trucks_on_truck_id", using: :btree

  create_table "fleets", force: :cascade do |t|
    t.string   "fleet_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  add_index "fleets", ["deleted_at"], name: "index_fleets_on_deleted_at", using: :btree

  create_table "sites", force: :cascade do |t|
    t.string   "name"
    t.boolean  "rural"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "address_id",  null: false
    t.string   "sites"
    t.string   "sites_names"
  end

  create_table "sites_trucks", id: false, force: :cascade do |t|
    t.integer "site_id",  null: false
    t.integer "truck_id", null: false
  end

  add_index "sites_trucks", ["site_id", "truck_id"], name: "index_sites_trucks_on_site_id_and_truck_id", using: :btree
  add_index "sites_trucks", ["truck_id", "site_id"], name: "index_sites_trucks_on_truck_id_and_site_id", using: :btree

  create_table "sponsors", force: :cascade do |t|
    t.string   "name"
    t.string   "logo"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "company_id"
  end

  create_table "states", force: :cascade do |t|
    t.string   "abbreviation", null: false
    t.string   "name",         null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "truck_models", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trucks", force: :cascade do |t|
    t.string   "registration",          null: false
    t.integer  "truck_model_id"
    t.integer  "driver_id"
    t.datetime "scheduled_maintenance"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "trucks", ["driver_id"], name: "index_trucks_on_driver_id", using: :btree
  add_index "trucks", ["truck_model_id"], name: "index_trucks_on_truck_model_id", using: :btree

  create_table "users", force: :cascade do |t|
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
    t.integer  "role",                                null: false
    t.datetime "deleted_at"
    t.integer  "site_id"
    t.datetime "birth_date"
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "users", ["deleted_at"], name: "index_users_on_deleted_at", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["site_id"], name: "index_users_on_site_id", using: :btree

  add_foreign_key "trucks", "truck_models"
end
