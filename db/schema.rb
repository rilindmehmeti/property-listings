# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_08_193638) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "listings", force: :cascade do |t|
    t.string "title"
    t.decimal "default_daily_rate", default: "0.0"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "seasonal_rates", force: :cascade do |t|
    t.bigint "listing_id"
    t.date "start_date"
    t.date "end_date"
    t.decimal "daily_rate", default: "0.0"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["end_date"], name: "index_seasonal_rates_on_end_date"
    t.index ["listing_id"], name: "index_seasonal_rates_on_listing_id"
    t.index ["start_date"], name: "index_seasonal_rates_on_start_date"
  end

  add_foreign_key "seasonal_rates", "listings"
end
