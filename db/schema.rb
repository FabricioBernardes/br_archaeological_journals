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

ActiveRecord::Schema[7.1].define(version: 2025_05_27_161910) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "article_authors", force: :cascade do |t|
    t.bigint "article_id", null: false
    t.bigint "author_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_article_authors_on_article_id"
    t.index ["author_id"], name: "index_article_authors_on_author_id"
  end

  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.text "abstract"
    t.string "doi"
    t.string "article_url"
    t.string "language"
    t.string "research_theme"
    t.string "publication_type"
    t.string "main_methodology"
    t.text "institutions"
    t.string "data_source"
    t.text "database_citation"
    t.string "states"
    t.boolean "spatial_analysis"
    t.text "laboratory_methods"
    t.text "datings"
    t.bigint "edition_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["edition_id"], name: "index_articles_on_edition_id"
  end

  create_table "articles_bibliographic_references", id: false, force: :cascade do |t|
    t.bigint "article_id", null: false
    t.bigint "bibliographic_reference_id", null: false
  end

  create_table "articles_keywords", id: false, force: :cascade do |t|
    t.bigint "article_id", null: false
    t.bigint "keyword_id", null: false
    t.index ["article_id", "keyword_id"], name: "index_articles_keywords_on_article_id_and_keyword_id"
    t.index ["keyword_id", "article_id"], name: "index_articles_keywords_on_keyword_id_and_article_id"
  end

  create_table "author_refs", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "author_refs_bibliographic_references", id: false, force: :cascade do |t|
    t.bigint "author_ref_id", null: false
    t.bigint "bibliographic_reference_id", null: false
    t.index ["author_ref_id", "bibliographic_reference_id"], name: "idx_authref_bibref_authref_bibref"
    t.index ["bibliographic_reference_id", "author_ref_id"], name: "idx_bibref_authref_bibref_authref"
  end

  create_table "authors", force: :cascade do |t|
    t.string "name"
    t.string "country_of_origin"
    t.string "institutional_affiliation"
    t.string "specialization_area"
    t.text "academic_background"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bibliographic_references", force: :cascade do |t|
    t.string "reference_type"
    t.integer "year"
    t.string "title"
    t.string "publisher"
    t.string "publication_location"
    t.string "doi"
    t.string "language"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "editions", force: :cascade do |t|
    t.string "volume"
    t.date "publication_date"
    t.text "editors"
    t.string "theme"
    t.string "edition_type"
    t.string "url"
    t.string "doi"
    t.string "available_format"
    t.bigint "scientific_journal_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["scientific_journal_id"], name: "index_editions_on_scientific_journal_id"
  end

  create_table "keywords", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scientific_journals", force: :cascade do |t|
    t.string "name"
    t.string "institutional_affiliation"
    t.string "issn"
    t.text "thematic_scope"
    t.string "website_url"
    t.string "periodicity"
    t.string "current_status"
    t.integer "foundation_year"
    t.integer "closure_year"
    t.string "qualis"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "article_authors", "articles"
  add_foreign_key "article_authors", "authors"
  add_foreign_key "articles", "editions"
  add_foreign_key "editions", "scientific_journals"
end
