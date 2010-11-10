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

ActiveRecord::Schema.define(:version => 20101110120809) do

  create_table "dungeons", :force => true do |t|
    t.string   "name",       :limit => 200,                :null => false
    t.integer  "levels",                    :default => 1, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "dungeons", ["name"], :name => "index_dungeons_on_name", :unique => true

  create_table "evil_wizards", :force => true do |t|
    t.string   "name",              :limit => 200,                :null => false
    t.integer  "experience_points",                :default => 1, :null => false
    t.string   "magic_school",                                    :null => false
    t.integer  "dungeon_id",                                      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "evil_wizards", ["name"], :name => "index_evil_wizards_on_name", :unique => true

  create_table "traps", :force => true do |t|
    t.string   "name",               :limit => 200,                :null => false
    t.integer  "base_damage_caused",                :default => 1, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "traps", ["name"], :name => "index_traps_on_name", :unique => true

end
