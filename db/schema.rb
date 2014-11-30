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

ActiveRecord::Schema.define(version: 0) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ingredients", force: true do |t|
    t.text    "name",                          null: false
    t.integer "recipe_frequency", default: 0,  null: false
    t.integer "recipe_ids",       default: [], null: false, array: true
  end

  create_table "recipes", force: true do |t|
    t.text    "source_uri",                         null: false
    t.text    "source_ingredients", default: [],    null: false, array: true
    t.integer "ingredient_ids",     default: [],    null: false, array: true
    t.boolean "has_been_scraped",   default: false, null: false
    t.text    "title"
    t.text    "description"
  end

end
