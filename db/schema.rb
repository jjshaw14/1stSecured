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

ActiveRecord::Schema.define(version: 20180620154307) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addons", force: :cascade do |t|
    t.bigint "package_id"
    t.string "name"
    t.bigint "cost_in_cents"
    t.integer "price_in_cents"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "fee_in_cents", default: 0
    t.index ["package_id"], name: "index_addons_on_package_id"
  end

  create_table "claims", force: :cascade do |t|
    t.bigint "contract_id"
    t.bigint "provider_id"
    t.integer "cost_in_cents"
    t.integer "odometer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.string "shop_name"
    t.string "shop_phone"
    t.string "shop_address"
    t.string "shop_rep"
    t.text "shop_notes"
    t.datetime "authorized_at"
    t.datetime "repaired_at"
    t.text "notes"
    t.boolean "can_it_be_safely_moved"
    t.string "location"
    t.text "issue"
    t.string "attachment"
    t.index ["contract_id"], name: "index_claims_on_contract_id"
    t.index ["provider_id"], name: "index_claims_on_provider_id"
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
    t.string "signed_copy"
    t.string "vin"
    t.string "make"
    t.string "model"
    t.string "year"
    t.string "stock_number"
    t.integer "odometer"
    t.date "purchased_on"
    t.integer "fee_in_cents"
    t.integer "price_in_cents"
    t.bigint "coverage_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.integer "cost_in_cents"
    t.integer "limit_in_miles"
    t.integer "length_in_months"
    t.boolean "up_to"
    t.text "varchar_template"
    t.integer "updated_odometer"
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
    t.bigint "cost_in_cents"
    t.text "caveat"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order"
    t.integer "fee_in_cents", default: 0
    t.boolean "up_to", default: false
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
    t.datetime "deleted_at"
  end

  create_table "fees", force: :cascade do |t|
    t.integer "length_in_months"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "packages", force: :cascade do |t|
    t.bigint "template_id"
    t.string "name"
    t.text "terms"
    t.boolean "absolute_mileage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order"
    t.index ["template_id"], name: "index_packages_on_template_id"
  end

  create_table "service_providers", force: :cascade do |t|
    t.string "name"
    t.string "address1"
    t.string "address2"
    t.string "address3"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "templates", force: :cascade do |t|
    t.bigint "dealership_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "terms"
    t.datetime "deleted_at"
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
    t.integer "user_type"
    t.index ["dealership_id"], name: "index_users_on_dealership_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.text "object_changes"
    t.bigint "contract_id"
    t.bigint "template_id"
    t.bigint "dealership_id"
    t.bigint "user_id"
    t.string "request_id"
    t.string "request_ip"
    t.datetime "created_at"
    t.index ["contract_id"], name: "index_versions_on_contract_id"
    t.index ["dealership_id"], name: "index_versions_on_dealership_id"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
    t.index ["request_id"], name: "index_versions_on_request_id"
    t.index ["request_ip"], name: "index_versions_on_request_ip"
    t.index ["template_id"], name: "index_versions_on_template_id"
    t.index ["user_id"], name: "index_versions_on_user_id"
  end

end
