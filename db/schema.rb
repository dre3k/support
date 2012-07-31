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

ActiveRecord::Schema.define(:version => 20120731135757) do

  create_table "customers", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "email",      :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "customers", ["email"], :name => "index_customers_on_email", :unique => true

  create_table "histories", :force => true do |t|
    t.integer  "ticket_id",  :null => false
    t.integer  "reply_id",   :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "histories", ["ticket_id"], :name => "index_histories_on_ticket_id"

  create_table "members", :force => true do |t|
    t.string   "username",        :null => false
    t.string   "password_digest", :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "members", ["username"], :name => "index_members_on_username", :unique => true

  create_table "replies", :force => true do |t|
    t.integer  "owner_from_id"
    t.integer  "owner_to_id"
    t.integer  "status_from_id"
    t.integer  "status_to_id"
    t.text     "message",        :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "ticket_statuses", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "ticket_statuses", ["name"], :name => "index_ticket_statuses_on_name", :unique => true

  create_table "tickets", :force => true do |t|
    t.string   "no"
    t.string   "dep",        :null => false
    t.string   "subject",    :null => false
    t.text     "message",    :null => false
    t.string   "url"
    t.integer  "owner_id"
    t.integer  "status_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "tickets", ["no"], :name => "index_tickets_on_no", :unique => true
  add_index "tickets", ["owner_id"], :name => "index_tickets_on_owner_id"
  add_index "tickets", ["status_id"], :name => "index_tickets_on_status_id"
  add_index "tickets", ["subject"], :name => "index_tickets_on_subject"

end
