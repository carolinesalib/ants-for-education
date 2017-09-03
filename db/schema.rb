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

ActiveRecord::Schema.define(version: 20170903151931) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "classroom_disciplines", force: :cascade do |t|
    t.integer  "ieducar_code"
    t.string   "name"
    t.integer  "course_load"
    t.integer  "classroom_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["classroom_id"], name: "index_classroom_disciplines_on_classroom_id", using: :btree
  end

  create_table "classrooms", force: :cascade do |t|
    t.integer  "ieducar_code"
    t.string   "name"
    t.time     "start_at"
    t.time     "stop_at"
    t.time     "interval_start"
    t.time     "interval_stop"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "courses", force: :cascade do |t|
    t.integer  "ieducar_code"
    t.string   "name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "ieducar_configurations", force: :cascade do |t|
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schools", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "ieducar_code"
  end

  create_table "series", force: :cascade do |t|
    t.integer  "ieducar_code"
    t.string   "name"
    t.integer  "course_load"
    t.integer  "school_days"
    t.integer  "interval"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "teacher_disciplines", force: :cascade do |t|
    t.string   "ieducar_code"
    t.string   "name"
    t.integer  "teacher_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["teacher_id"], name: "index_teacher_disciplines_on_teacher_id", using: :btree
  end

  create_table "teacher_schools", force: :cascade do |t|
    t.string   "ieducar_code"
    t.string   "name"
    t.integer  "course_load"
    t.integer  "teacher_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "period"
    t.index ["teacher_id"], name: "index_teacher_schools_on_teacher_id", using: :btree
  end

  create_table "teachers", force: :cascade do |t|
    t.string   "ieducar_code"
    t.string   "name"
    t.integer  "course_load"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "classroom_disciplines", "classrooms"
  add_foreign_key "teacher_disciplines", "teachers"
  add_foreign_key "teacher_schools", "teachers"
end
