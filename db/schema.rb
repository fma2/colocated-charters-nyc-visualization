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

ActiveRecord::Schema.define(version: 20150201221353) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "buildings", force: true do |t|
    t.string   "primary_address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schools", force: true do |t|
    t.string   "ats_system_code"
    t.string   "location_code"
    t.string   "location_name"
    t.string   "managed_by_name"
    t.string   "location_type_description"
    t.string   "location_category_description"
    t.string   "grades"
    t.string   "grades_final"
    t.string   "open_date"
    t.string   "status_description"
    t.string   "building_code"
    t.string   "primary_address"
    t.string   "city"
    t.string   "state_code"
    t.string   "zip"
    t.string   "geographical_district_code"
    t.string   "administrative_district_code"
    t.string   "administrative_district_location_code"
    t.string   "administrative_district_name"
    t.string   "same_address_as_another_school"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "full_street_address"
    t.integer  "building_id"
    t.date     "opening_date"
  end

end
