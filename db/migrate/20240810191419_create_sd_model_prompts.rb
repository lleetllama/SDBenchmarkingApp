class CreateSdModelPrompts < ActiveRecord::Migration[7.1]
  def change
    create_table :sd_model_prompts do |t|
      t.references :sd_model, null: false, foreign_key: true
      t.references :sd_prompt, null: false, foreign_key: true
      t.string :sd_uuid
      t.string :img_url

      t.timestamps
    end
  end
end
