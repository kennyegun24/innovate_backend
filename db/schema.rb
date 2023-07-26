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

ActiveRecord::Schema[7.0].define(version: 2023_07_25_081228) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "applied_jobs", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_applied_jobs_on_job_id"
    t.index ["user_id"], name: "index_applied_jobs_on_user_id"
  end

  create_table "article_comments", force: :cascade do |t|
    t.string "user_name"
    t.string "user_image"
    t.string "text"
    t.bigint "articles_id"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["articles_id"], name: "index_article_comments_on_articles_id"
    t.index ["author_id"], name: "index_article_comments_on_author_id"
  end

  create_table "article_likes", force: :cascade do |t|
    t.bigint "article_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_article_likes_on_article_id"
    t.index ["user_id"], name: "index_article_likes_on_user_id"
  end

  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.string "text"
    t.string "author_name"
    t.string "author_image"
    t.integer "likes_counter", default: 0
    t.integer "comments_counter", default: 0
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "blogs_id", null: false
    t.index ["blogs_id"], name: "index_articles_on_blogs_id"
  end

  create_table "blogs", force: :cascade do |t|
    t.string "author_name"
    t.string "author_image"
    t.integer "likes_counter", default: 0
    t.integer "comments_counter", default: 0
    t.integer "articles_counter", default: 0
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_blogs_on_author_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "email"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "company_details", force: :cascade do |t|
    t.string "company_name"
    t.string "capacity"
    t.string "creation_date"
    t.string "about"
    t.integer "post_count"
    t.integer "followers_count"
    t.integer "open_jobs"
    t.string "company_image"
    t.bigint "company_id", null: false
    t.string "header"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_company_details_on_company_id"
  end

  create_table "followers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "follower_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["follower_user_id", "user_id"], name: "index_followers_on_follower_user_id_and_user_id", unique: true
    t.index ["follower_user_id"], name: "index_followers_on_follower_user_id"
    t.index ["user_id"], name: "index_followers_on_user_id"
  end

  create_table "followings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "following_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["following_user_id", "user_id"], name: "index_followings_on_following_user_id_and_user_id", unique: true
    t.index ["following_user_id"], name: "index_followings_on_following_user_id"
    t.index ["user_id"], name: "index_followings_on_user_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.string "company_name"
    t.string "company_image"
    t.string "description"
    t.string "title"
    t.string "expiry_date"
    t.string "location"
    t.string "experience_level"
    t.integer "no_of_applicants"
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_jobs_on_company_id"
  end

  create_table "post_comments", force: :cascade do |t|
    t.string "commentor_name"
    t.string "commentor_image"
    t.string "text"
    t.bigint "user_id", null: false
    t.bigint "post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_post_comments_on_post_id"
    t.index ["user_id"], name: "index_post_comments_on_user_id"
  end

  create_table "post_likes", force: :cascade do |t|
    t.string "user_image"
    t.string "user_name"
    t.bigint "user_id", null: false
    t.bigint "post_id", null: false
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
    t.integer "likes_count", default: 0
    t.integer "comments_count", default: 0
    t.bigint "author_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_posts_on_author_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "user_name", null: false
    t.string "email", null: false
    t.string "password_digest"
    t.string "image", default: "https://res.cloudinary.com/drfqge33t/image/upload/v1684591863/noImage_ynt833.png"
    t.string "header"
    t.string "about"
    t.string "bio"
    t.string "profession"
    t.string "location"
    t.integer "blogs_count", default: 0
    t.integer "posts_count", default: 0
    t.string "website1"
    t.string "website2"
    t.string "website3"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phoneNumber"
    t.string "school"
    t.string "company"
    t.string "work"
    t.string "start_date"
    t.integer "followers_count", default: 0
    t.integer "following_count", default: 0
  end

  create_table "work_experiences", force: :cascade do |t|
    t.string "company_name"
    t.string "title"
    t.string "description"
    t.string "start_date"
    t.string "end_date"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_work_experiences_on_user_id"
  end

  add_foreign_key "applied_jobs", "jobs"
  add_foreign_key "applied_jobs", "users"
  add_foreign_key "article_comments", "articles", column: "articles_id"
  add_foreign_key "article_comments", "users", column: "author_id"
  add_foreign_key "article_likes", "articles"
  add_foreign_key "article_likes", "users"
  add_foreign_key "articles", "blogs", column: "blogs_id"
  add_foreign_key "blogs", "users", column: "author_id"
  add_foreign_key "company_details", "companies"
  add_foreign_key "followers", "users"
  add_foreign_key "followers", "users", column: "follower_user_id"
  add_foreign_key "followings", "users"
  add_foreign_key "followings", "users", column: "following_user_id"
  add_foreign_key "jobs", "companies"
  add_foreign_key "post_comments", "posts"
  add_foreign_key "post_comments", "users"
  add_foreign_key "post_likes", "posts"
  add_foreign_key "post_likes", "users"
  add_foreign_key "posts", "users", column: "author_id"
  add_foreign_key "work_experiences", "users"
end
