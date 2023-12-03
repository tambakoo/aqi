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

ActiveRecord::Schema[7.1].define(version: 2023_12_01_172235) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "air_quality_logs", force: :cascade do |t|
    t.bigint "city_id", null: false
    t.integer "index", null: false
    t.jsonb "concentrations", default: {}
    t.datetime "recorded_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_air_quality_logs_on_city_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name", null: false
    t.string "country_code", null: false
    t.decimal "latitude"
    t.decimal "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "air_quality_logs", "cities"
end
