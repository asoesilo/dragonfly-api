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

ActiveRecord::Schema.define(version: 20140620222408) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actions", force: true do |t|
    t.string "name"
  end

  create_table "friends", force: true do |t|
    t.integer  "user1_id"
    t.integer  "user2_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "genders", force: true do |t|
    t.string "description"
  end

  create_table "languages", force: true do |t|
    t.string "name"
  end

  create_table "proficiencies", force: true do |t|
    t.string "name"
  end

  create_table "user_languages", force: true do |t|
    t.integer  "user_id"
    t.integer  "language_id"
    t.integer  "proficiency_id"
    t.integer  "action_id"
    t.date     "start_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password"
    t.string   "firstname"
    t.string   "lastname"
    t.date     "birthday"
    t.integer  "gender_id"
    t.text     "about"
    t.boolean  "is_online"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
