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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20131111135157) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "members", force: true do |t|
    t.string   "name",       null: false
    t.string   "website",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendships", force: true do |t|
    t.integer  "member_id",  null: false
    t.integer  "friend_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["friend_id"], :name => "fk__friendships_friend_id"
    t.index ["member_id"], :name => "fk__friendships_member_id"
    t.index ["member_id", "friend_id"], :name => "index_friendships_on_member_id_and_friend_id", :unique => true
    t.foreign_key ["friend_id"], "members", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_friendships_friend_id"
    t.foreign_key ["member_id"], "members", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_friendships_member_id"
  end

  create_table "shortened_urls", force: true do |t|
    t.integer  "owner_id"
    t.string   "owner_type", limit: 20
    t.string   "url",                               null: false
    t.string   "unique_key", limit: 10,             null: false
    t.integer  "use_count",             default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["owner_id", "owner_type"], :name => "index_shortened_urls_on_owner_id_and_owner_type"
    t.index ["unique_key"], :name => "index_shortened_urls_on_unique_key", :unique => true
    t.index ["url"], :name => "index_shortened_urls_on_url"
  end

  create_table "topics", force: true do |t|
    t.string   "title",                null: false
    t.integer  "level",      limit: 2, null: false
    t.integer  "member_id",            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["member_id"], :name => "index_topics_on_member_id"
    t.foreign_key ["member_id"], "members", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_topics_member_id"
  end

end
