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

ActiveRecord::Schema[7.1].define(version: 2026_01_26_133631) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "animals", force: :cascade do |t|
    t.string "name"
    t.string "age"
    t.string "sex"
    t.string "species"
    t.bigint "client_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_animals_on_client_id"
  end

  create_table "appointments", force: :cascade do |t|
    t.text "chief_complaint"
    t.text "medical_history"
    t.text "suspected_exams"
    t.bigint "animal_id", null: false
    t.bigint "client_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["animal_id"], name: "index_appointments_on_animal_id"
    t.index ["client_id"], name: "index_appointments_on_client_id"
    t.index ["user_id"], name: "index_appointments_on_user_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.string "cpf"
    t.string "rg"
    t.string "phone"
    t.string "address"
    t.string "number_address"
    t.string "compl_address"
    t.string "neighborhoods"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["cpf"], name: "index_clients_on_cpf", unique: true
  end

  create_table "clinic_services", force: :cascade do |t|
    t.string "name"
    t.decimal "cost_value"
    t.decimal "total_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ticket_items", force: :cascade do |t|
    t.bigint "ticket_id", null: false
    t.string "item_type", null: false
    t.bigint "reference_id"
    t.string "description", null: false
    t.integer "quantity", default: 1, null: false
    t.decimal "unit_price", precision: 10, scale: 2, null: false
    t.decimal "total_price", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "discount", precision: 10, scale: 2, default: "0.0"
    t.index ["item_type", "reference_id"], name: "index_ticket_items_on_item_type_and_reference_id"
    t.index ["ticket_id"], name: "index_ticket_items_on_ticket_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "animal_id", null: false
    t.decimal "subtotal", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "discount", precision: 10, scale: 2, default: "0.0"
    t.decimal "surcharge", precision: 10, scale: 2, default: "0.0"
    t.decimal "total_amount", precision: 10, scale: 2, default: "0.0", null: false
    t.string "payment_status", default: "pendente"
    t.string "payment_method"
    t.datetime "payment_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["animal_id"], name: "index_tickets_on_animal_id"
    t.index ["user_id"], name: "index_tickets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "crmv"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vaccine_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  create_table "vaccines", force: :cascade do |t|
    t.bigint "animal_id", null: false
    t.bigint "vaccine_type_id", null: false
    t.date "application_date"
    t.date "return_date"
    t.string "applied_dose"
    t.text "obs"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["animal_id"], name: "index_vaccines_on_animal_id"
    t.index ["vaccine_type_id"], name: "index_vaccines_on_vaccine_type_id"
  end

  create_table "weights", force: :cascade do |t|
    t.string "kg"
    t.bigint "animal_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["animal_id"], name: "index_weights_on_animal_id"
    t.index ["user_id"], name: "index_weights_on_user_id"
  end

  add_foreign_key "animals", "clients"
  add_foreign_key "appointments", "animals"
  add_foreign_key "appointments", "clients"
  add_foreign_key "appointments", "users"
  add_foreign_key "ticket_items", "tickets"
  add_foreign_key "tickets", "animals"
  add_foreign_key "tickets", "users"
  add_foreign_key "vaccines", "animals"
  add_foreign_key "vaccines", "vaccine_types"
  add_foreign_key "weights", "animals"
  add_foreign_key "weights", "users"
end
