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

ActiveRecord::Schema.define(version: 2021_06_07_202056) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "recipes", force: :cascade do |t|
    t.string "name"
    t.string "image_url"
    t.integer "cook_time"
    t.integer "prep_time"
    t.integer "total_time"
    t.string "author", limit: 128
    t.integer "nb_comments"
    t.integer "people_quantity"
    t.string "budget"
    t.string "difficulty"
    t.decimal "rate"
    t.string "author_tip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "recipes_tags", force: :cascade do |t|
    t.bigint "recipes_id"
    t.bigint "tags_id"
    t.index ["recipes_id"], name: "index_recipes_tags_on_recipes_id"
    t.index ["tags_id"], name: "index_recipes_tags_on_tags_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
