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

ActiveRecord::Schema[7.0].define(version: 2023_10_27_121627) do
  create_table "authors", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "birth_date"
    t.integer "books_id"
    t.integer "newsletters_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["books_id"], name: "index_authors_on_books_id"
    t.index ["newsletters_id"], name: "index_authors_on_newsletters_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "name"
    t.integer "author_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_books_on_author_id"
  end

  create_table "newsletters", force: :cascade do |t|
    t.boolean "active"
    t.string "title"
    t.text "content"
    t.integer "subscription_id"
    t.integer "author_id", null: false
    t.integer "book_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_newsletters_on_author_id"
    t.index ["book_id"], name: "index_newsletters_on_book_id"
    t.index ["subscription_id"], name: "index_newsletters_on_subscription_id"
  end

  create_table "readers", force: :cascade do |t|
    t.string "email"
    t.string "password"
    t.string "password_digest"
    t.integer "subscriptions_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subscriptions_id"], name: "index_readers_on_subscriptions_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer "reader_id", null: false
    t.integer "newsletter_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["newsletter_id"], name: "index_subscriptions_on_newsletter_id"
    t.index ["reader_id"], name: "index_subscriptions_on_reader_id"
  end

  add_foreign_key "authors", "books", column: "books_id"
  add_foreign_key "authors", "newsletters", column: "newsletters_id"
  add_foreign_key "books", "authors", on_delete: :cascade
  add_foreign_key "newsletters", "authors", on_delete: :cascade
  add_foreign_key "newsletters", "books", on_delete: :cascade
  add_foreign_key "newsletters", "subscriptions"
  add_foreign_key "readers", "subscriptions", column: "subscriptions_id"
  add_foreign_key "subscriptions", "newsletters"
  add_foreign_key "subscriptions", "readers"
end
