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

ActiveRecord::Schema[7.1].define(version: 2024_10_02_134549) do
  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "required", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "movies", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "review_ratings", force: :cascade do |t|
    t.integer "review_id", null: false
    t.integer "category_id", null: false
    t.integer "score", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_review_ratings_on_category_id"
    t.index ["review_id", "category_id"], name: "index_review_ratings_on_review_id_and_category_id", unique: true
    t.index ["review_id"], name: "index_review_ratings_on_review_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "movie_id", null: false
    t.string "reviewer_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_reviews_on_movie_id"
  end

  add_foreign_key "review_ratings", "categories"
  add_foreign_key "review_ratings", "reviews"
  add_foreign_key "reviews", "movies"
end
