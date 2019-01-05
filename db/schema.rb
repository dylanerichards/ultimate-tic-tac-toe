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

ActiveRecord::Schema.define(version: 2019_01_04_193523) do

  create_table "games", force: :cascade do |t|
    t.text "board", default: "--- []\n"
    t.text "valid_subgames", default: "---\n- 0\n- 1\n- 2\n- 3\n- 4\n- 5\n- 6\n- 7\n- 8\n"
    t.string "winner", default: ""
    t.string "turn", default: "X"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
