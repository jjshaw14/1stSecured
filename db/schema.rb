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

ActiveRecord::Schema.define(version: 20180126021634) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addons", force: :cascade do |t|
    t.bigint "package_id"
    t.string "name"
    t.integer "amount_in_cents"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["package_id"], name: "index_addons_on_package_id"
  end

  create_table "claims", force: :cascade do |t|
    t.bigint "contract_id"
    t.integer "odometer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contract_id"], name: "index_claims_on_contract_id"
  end

  create_table "contract_addons", force: :cascade do |t|
    t.bigint "contract_id"
    t.bigint "addon_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["addon_id"], name: "index_contract_addons_on_addon_id"
    t.index ["contract_id"], name: "index_contract_addons_on_contract_id"
  end

  create_table "contracts", force: :cascade do |t|
    t.bigint "dealership_id"
    t.bigint "template_id"
    t.integer "reference_number"
    t.bigint "created_by_id"
    t.bigint "submitted_by_id"
    t.datetime "submitted_at"
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "home_number"
    t.string "work_number"
    t.string "mobile_number"
    t.string "address1"
    t.string "address2"
    t.string "address3"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "vin"
    t.string "make"
    t.string "model"
    t.string "year"
    t.integer "odometer"
    t.date "purchased_on"
    t.bigint "coverage_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coverage_id"], name: "index_contracts_on_coverage_id"
    t.index ["created_by_id"], name: "index_contracts_on_created_by_id"
    t.index ["dealership_id"], name: "index_contracts_on_dealership_id"
    t.index ["submitted_by_id"], name: "index_contracts_on_submitted_by_id"
    t.index ["template_id"], name: "index_contracts_on_template_id"
  end

  create_table "coverages", force: :cascade do |t|
    t.bigint "package_id"
    t.integer "length_in_months"
    t.integer "limit_in_miles"
    t.text "caveat"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["package_id"], name: "index_coverages_on_package_id"
  end

  create_table "dealerships", force: :cascade do |t|
    t.string "name"
    t.string "address1"
    t.string "address2"
    t.string "address3"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "packages", force: :cascade do |t|
    t.bigint "template_id"
    t.string "name"
    t.text "terms"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["template_id"], name: "index_packages_on_template_id"
  end

  create_table "templates", force: :cascade do |t|
    t.bigint "dealership_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dealership_id"], name: "index_templates_on_dealership_id"
  end

  create_table "users", force: :cascade do |t|
    t.bigint "dealership_id"
    t.string "first_name"
    t.string "last_name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "provider"
    t.string "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dealership_id"], name: "index_users_on_dealership_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
