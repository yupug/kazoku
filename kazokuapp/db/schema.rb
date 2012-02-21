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

ActiveRecord::Schema.define(:version => 20120221141401) do

  create_table "comments", :force => true do |t|
    t.integer  "kazoku_id"
    t.integer  "user_id"
    t.integer  "photo_id"
    t.text     "comment"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "comments", ["kazoku_id"], :name => "index_comments_on_kazoku_id"
  add_index "comments", ["photo_id"], :name => "index_comments_on_photo_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "contents", :force => true do |t|
    t.integer  "kazoku_id"
    t.integer  "user_id"
    t.binary   "data",       :limit => 16777215
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "contents", ["kazoku_id"], :name => "index_contents_on_kazoku_id"
  add_index "contents", ["user_id"], :name => "index_contents_on_user_id"

  create_table "kazokus", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "photos", :force => true do |t|
    t.integer  "kazoku_id"
    t.integer  "user_id"
    t.integer  "content_id"
    t.string   "title"
    t.string   "mime_type"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "image"
  end

  add_index "photos", ["content_id"], :name => "index_photos_on_content_id"
  add_index "photos", ["kazoku_id"], :name => "index_photos_on_kazoku_id"
  add_index "photos", ["user_id"], :name => "index_photos_on_user_id"

  create_table "timelines", :force => true do |t|
    t.integer  "kazoku_id"
    t.integer  "user_id"
    t.string   "action"
    t.string   "object1"
    t.string   "object2"
    t.string   "object3"
    t.string   "object4"
    t.string   "object5"
    t.string   "object6"
    t.string   "object7"
    t.string   "object8"
    t.string   "object9"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "timelines", ["kazoku_id"], :name => "index_timelines_on_kazoku_id"
  add_index "timelines", ["user_id"], :name => "index_timelines_on_user_id"

  create_table "users", :force => true do |t|
    t.integer  "kazoku_id"
    t.string   "email"
    t.string   "password"
    t.string   "name"
    t.string   "receive_email"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["kazoku_id"], :name => "index_users_on_kazoku_id"
  add_index "users", ["receive_email"], :name => "index_users_on_receive_email", :unique => true

end
