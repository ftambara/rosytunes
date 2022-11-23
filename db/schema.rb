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

ActiveRecord::Schema[7.0].define(version: 2022_11_23_142244) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: :cascade do |t|
    t.string "api_id", limit: 30, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["api_id"], name: "index_albums_on_api_id", unique: true
  end

  create_table "albums_artists", id: false, force: :cascade do |t|
    t.bigint "album_id", null: false
    t.bigint "artist_id", null: false
    t.index ["album_id", "artist_id"], name: "index_albums_artists_on_album_id_and_artist_id", unique: true
  end

  create_table "albums_songs", id: false, force: :cascade do |t|
    t.bigint "album_id", null: false
    t.bigint "song_id", null: false
    t.index ["album_id", "song_id"], name: "index_albums_songs_on_album_id_and_song_id"
  end

  create_table "artist_bookmarks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "artist_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_artist_bookmarks_on_artist_id"
    t.index ["user_id"], name: "index_artist_bookmarks_on_user_id"
  end

  create_table "artists", force: :cascade do |t|
    t.string "api_id", limit: 30, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["api_id"], name: "index_artists_on_api_id", unique: true
  end

  create_table "artists_songs", id: false, force: :cascade do |t|
    t.bigint "artist_id", null: false
    t.bigint "song_id", null: false
    t.index ["artist_id", "song_id"], name: "index_artists_songs_on_artist_id_and_song_id"
  end

  create_table "qualifications", force: :cascade do |t|
    t.bigint "quality_id", null: false
    t.bigint "rating_id", null: false
    t.integer "modifier", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quality_id"], name: "index_qualifications_on_quality_id"
    t.index ["rating_id"], name: "index_qualifications_on_rating_id"
  end

  create_table "qualities", force: :cascade do |t|
    t.string "name", null: false
    t.string "positive_variant"
    t.string "negative_variant"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_qualities_on_name", unique: true
  end

  create_table "ratings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "song_id", null: false
    t.integer "opinion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["song_id"], name: "index_ratings_on_song_id"
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "songs", force: :cascade do |t|
    t.string "api_id", limit: 30, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["api_id"], name: "index_songs_on_api_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "artist_bookmarks", "artists"
  add_foreign_key "artist_bookmarks", "users"
  add_foreign_key "qualifications", "qualities"
  add_foreign_key "qualifications", "ratings"
  add_foreign_key "ratings", "songs"
  add_foreign_key "ratings", "users"
end
