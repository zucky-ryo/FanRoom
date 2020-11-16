# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_16_063239) do

  create_table "fan_teams", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "team_name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "open_messages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "content", null: false
    t.bigint "user_id"
    t.bigint "open_room_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["open_room_id"], name: "index_open_messages_on_open_room_id"
    t.index ["user_id"], name: "index_open_messages_on_user_id"
  end

  create_table "open_room_fan_teams", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "open_room_id"
    t.bigint "fan_team_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["fan_team_id"], name: "index_open_room_fan_teams_on_fan_team_id"
    t.index ["open_room_id", "fan_team_id"], name: "index_open_room_fan_teams_on_open_room_id_and_fan_team_id", unique: true
    t.index ["open_room_id"], name: "index_open_room_fan_teams_on_open_room_id"
  end

  create_table "open_room_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "open_room_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["open_room_id"], name: "index_open_room_users_on_open_room_id"
    t.index ["user_id", "open_room_id"], name: "index_open_room_users_on_user_id_and_open_room_id", unique: true
    t.index ["user_id"], name: "index_open_room_users_on_user_id"
  end

  create_table "open_rooms", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "private_messages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "content", null: false
    t.bigint "user_id"
    t.bigint "private_room_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["private_room_id"], name: "index_private_messages_on_private_room_id"
    t.index ["user_id"], name: "index_private_messages_on_user_id"
  end

  create_table "private_room_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "private_room_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["private_room_id"], name: "index_private_room_users_on_private_room_id"
    t.index ["user_id", "private_room_id"], name: "index_private_room_users_on_user_id_and_private_room_id", unique: true
    t.index ["user_id"], name: "index_private_room_users_on_user_id"
  end

  create_table "private_rooms", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "relationships", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "follow_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["follow_id"], name: "index_relationships_on_follow_id"
    t.index ["user_id", "follow_id"], name: "index_relationships_on_user_id_and_follow_id", unique: true
    t.index ["user_id"], name: "index_relationships_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "nickname", null: false
    t.text "profile"
    t.date "birthday"
    t.bigint "fan_team_id"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["fan_team_id"], name: "index_users_on_fan_team_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "open_messages", "open_rooms"
  add_foreign_key "open_messages", "users"
  add_foreign_key "open_room_fan_teams", "fan_teams"
  add_foreign_key "open_room_fan_teams", "open_rooms"
  add_foreign_key "open_room_users", "open_rooms"
  add_foreign_key "open_room_users", "users"
  add_foreign_key "private_messages", "private_rooms"
  add_foreign_key "private_messages", "users"
  add_foreign_key "private_room_users", "private_rooms"
  add_foreign_key "private_room_users", "users"
  add_foreign_key "relationships", "users"
  add_foreign_key "relationships", "users", column: "follow_id"
  add_foreign_key "users", "fan_teams"
end
