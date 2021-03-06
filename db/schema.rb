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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111028071949) do

  create_table "feedbacks", :force => true do |t|
    t.integer  "user_id"
    t.string   "page"
    t.integer  "score"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
  end

  add_index "feedbacks", ["page"], :name => "index_feedbacks_on_page"

  create_table "places", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "lat"
    t.decimal  "long"
    t.text     "description", :limit => 16777215
  end

  create_table "ratings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "tour_id"
    t.integer  "score"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ratings", ["tour_id"], :name => "index_ratings_on_tour_id"
  add_index "ratings", ["user_id"], :name => "index_ratings_on_user_id"

  create_table "stops", :force => true do |t|
    t.integer  "tour_id"
    t.integer  "place_id"
    t.integer  "stop_num"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "notes"
  end

  add_index "stops", ["tour_id", "place_id", "stop_num"], :name => "index_stops_on_tour_id_and_place_id_and_order"

  create_table "tours", :force => true do |t|
    t.string   "name"
    t.text     "desc",          :limit => 16777215
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "duration"
    t.integer  "cost"
    t.decimal  "ratings_score"
    t.string   "url"
  end

  add_index "tours", ["url"], :name => "index_tours_on_url"
  add_index "tours", ["user_id"], :name => "index_tours_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "admin",              :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["url"], :name => "index_users_on_url"

end
