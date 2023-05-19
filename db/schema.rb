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

ActiveRecord::Schema[7.0].define(version: 2023_05_19_210551) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "post_comments", force: :cascade do |t|
    t.string "commentor_name"
    t.string "commentor_image"
    t.string "text"
    t.bigint "user_id"
    t.bigint "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_post_comments_on_post_id"
    t.index ["user_id"], name: "index_post_comments_on_user_id"
  end

  create_table "post_likes", force: :cascade do |t|
    t.string "user_image"
    t.string "user_name"
    t.bigint "user_id"
    t.bigint "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_post_likes_on_post_id"
    t.index ["user_id"], name: "index_post_likes_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "creator_name"
    t.string "creator_image"
    t.string "text"
    t.string "image"
    t.string "likes_count"
    t.string "comments_count"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_posts_on_author_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "user_name"
    t.string "email"
    t.string "password_digest"
    t.string "image"
    t.string "header"
    t.string "about"
    t.string "bio"
    t.string "profession"
    t.string "location"
    t.string "blogs_count"
    t.string "posts_count"
    t.string "website1"
    t.string "website2"
    t.string "website3"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "work_experiences", force: :cascade do |t|
    t.string "company_name"
    t.string "title"
    t.string "description"
    t.string "start_date"
    t.string "end_date"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_work_experiences_on_user_id"
  end

  add_foreign_key "post_comments", "posts"
  add_foreign_key "post_comments", "users"
  add_foreign_key "post_likes", "posts"
  add_foreign_key "post_likes", "users"
  add_foreign_key "posts", "users", column: "author_id"
  add_foreign_key "work_experiences", "users"
end
