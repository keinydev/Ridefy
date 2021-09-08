# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_09_08_151234) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "cars", force: :cascade do |t|
    t.string "license_plate", null: false
    t.string "car_type", null: false
    t.boolean "active", default: true, null: false
    t.bigint "driver_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["driver_id"], name: "index_cars_on_driver_id"
    t.index ["license_plate"], name: "index_cars_on_license_plate", unique: true
  end

  create_table "charges", force: :cascade do |t|
    t.decimal "total", null: false
    t.bigint "trip_id", null: false
    t.bigint "payment_method_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["payment_method_id"], name: "index_charges_on_payment_method_id"
    t.index ["trip_id"], name: "index_charges_on_trip_id"
  end

  create_table "drivers", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "phone", null: false
    t.string "email", null: false
    t.string "driving_license_number", null: false
    t.date "expiring_date", null: false
    t.boolean "working", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["driving_license_number"], name: "index_drivers_on_driving_license_number", unique: true
    t.index ["email"], name: "index_drivers_on_email", unique: true
  end

  create_table "payment_methods", force: :cascade do |t|
    t.string "type", default: "CARD", null: false
    t.string "token", null: false
    t.string "source_id", null: false
    t.bigint "rider_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["rider_id"], name: "index_payment_methods_on_rider_id"
  end

  create_table "riders", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.string "phone", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_riders_on_email", unique: true
  end

  create_table "trips", force: :cascade do |t|
    t.hstore "start_location", null: false
    t.hstore "end_location", null: false
    t.datetime "start_time", null: false
    t.datetime "end_time", null: false
    t.bigint "driver_id", null: false
    t.bigint "rider_id", null: false
    t.bigint "car_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["car_id"], name: "index_trips_on_car_id"
    t.index ["driver_id"], name: "index_trips_on_driver_id"
    t.index ["rider_id"], name: "index_trips_on_rider_id"
  end

  add_foreign_key "cars", "drivers"
  add_foreign_key "charges", "payment_methods"
  add_foreign_key "charges", "trips"
  add_foreign_key "payment_methods", "riders"
  add_foreign_key "trips", "cars"
  add_foreign_key "trips", "drivers"
  add_foreign_key "trips", "riders"
end
