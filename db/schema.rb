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

ActiveRecord::Schema.define(version: 20160527182411) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "course_groups", force: :cascade do |t|
    t.time     "start_time"
    t.time     "end_time"
    t.integer  "weekday"
    t.integer  "subject_id"
    t.integer  "lecturer_id"
    t.integer  "max_limit"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "group_type"
  end

  create_table "course_groups_users", id: false, force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "course_group_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "course_groups_users", ["course_group_id"], name: "index_course_groups_users_on_course_group_id", using: :btree
  add_index "course_groups_users", ["user_id", "course_group_id"], name: "by_user_and_course_group", unique: true, using: :btree
  add_index "course_groups_users", ["user_id"], name: "index_course_groups_users_on_user_id", using: :btree

  create_table "faculties", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "field_of_studies", force: :cascade do |t|
    t.string   "title",      default: ""
    t.string   "mode",       default: ""
    t.string   "degree",     default: ""
    t.integer  "dean_id"
    t.integer  "faculty_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "grades", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "course_group_id"
    t.float    "value"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "grades", ["course_group_id"], name: "index_grades_on_course_group_id", using: :btree
  add_index "grades", ["user_id"], name: "index_grades_on_user_id", using: :btree

  create_table "registrations", force: :cascade do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "field_of_study_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "semesters", force: :cascade do |t|
    t.integer  "field_of_study_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "period_type"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "semesters_users", id: false, force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "semester_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "semesters_users", ["semester_id"], name: "index_semesters_users_on_semester_id", using: :btree
  add_index "semesters_users", ["user_id"], name: "index_semesters_users_on_user_id", using: :btree

  create_table "subjects", force: :cascade do |t|
    t.string   "title"
    t.integer  "coordinator_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.text     "description"
    t.text     "short_description"
    t.text     "literature"
    t.text     "requirements"
    t.text     "learning_outcomes"
    t.integer  "semester_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",        null: false
    t.string   "encrypted_password",     default: "",        null: false
    t.string   "first_name"
    t.string   "last_name"
    t.date     "birth_date"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,         null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "index_num"
    t.string   "street"
    t.string   "postal_code"
    t.string   "city"
    t.string   "country"
    t.string   "bank_account"
    t.string   "role",                   default: "Student"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["index_num"], name: "index_users_on_index_num", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
