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

ActiveRecord::Schema[7.1].define(version: 2025_08_15_121744) do
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
  add_foreign_key "vaccines", "animals"
  add_foreign_key "vaccines", "vaccine_types"
  add_foreign_key "weights", "animals"
  add_foreign_key "weights", "users"
end
