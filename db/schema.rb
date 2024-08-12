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

ActiveRecord::Schema[7.1].define(version: 2024_08_11_221553) do
  create_table "sd_model_prompts", force: :cascade do |t|
    t.integer "sd_model_id", null: false
    t.integer "sd_prompt_id", null: false
    t.string "sd_uuid"
    t.string "img_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sd_model_id"], name: "index_sd_model_prompts_on_sd_model_id"
    t.index ["sd_prompt_id"], name: "index_sd_model_prompts_on_sd_prompt_id"
  end

  create_table "sd_models", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "ckpt_path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "sample_image_url"
    t.string "civitai_link"
  end

  create_table "sd_prompts", force: :cascade do |t|
    t.text "pos"
    t.text "neg"
    t.integer "width"
    t.integer "height"
    t.integer "seed"
    t.integer "cfg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "sample_image_url"
  end

  add_foreign_key "sd_model_prompts", "sd_models"
  add_foreign_key "sd_model_prompts", "sd_prompts"
end
