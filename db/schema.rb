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

ActiveRecord::Schema[7.2].define(version: 0) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_trgm"
  enable_extension "plpgsql"
  enable_extension "unaccent"
  enable_extension "uuid-ossp"

  create_table "SequelizeMeta", primary_key: "name", id: { type: :string, limit: 255 }, force: :cascade do |t|
  end

  create_table "categories", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.text "description"
    t.timestamptz "created_at", null: false
    t.timestamptz "updated_at", null: false
    t.string "slug", limit: 255

    t.unique_constraint ["name"], name: "categories_name_key"
  end

  create_table "posts", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "title", limit: 255
    t.text "content"
    t.string "source_url", limit: 255
    t.string "style", limit: 255
    t.string "crawl_status", limit: 255
    t.timestamptz "crawl_time"
    t.timestamptz "ai_process_time"
    t.uuid "category_id"
    t.timestamptz "created_at", null: false
    t.timestamptz "updated_at", null: false
    t.string "normalized_title", limit: 255
    t.index ["normalized_title"], name: "idx_posts_normalized_title_gin", opclass: :gin_trgm_ops, using: :gin
  end

  add_foreign_key "posts", "categories", name: "posts_category_id_fkey", on_update: :cascade, on_delete: :nullify
end
