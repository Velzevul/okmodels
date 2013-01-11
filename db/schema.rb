# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20130111155908) do

  create_table "models", :force => true do |t|
    t.string   "full_name"
    t.date     "date_of_birth"
    t.string   "email"
    t.integer  "height"
    t.integer  "shoes"
    t.string   "hair"
    t.string   "eyes"
    t.boolean  "confirmed"
    t.integer  "bust"
    t.integer  "waist"
    t.integer  "heaps"
    t.string   "type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "models", ["type"], :name => "index_models_on_type"

  create_table "photos", :force => true do |t|
    t.integer  "model_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "photos", ["model_id"], :name => "index_photos_on_model_id"

end
