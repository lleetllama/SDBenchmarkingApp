class CreateSdPrompts < ActiveRecord::Migration[7.1]
  def change
    create_table :sd_prompts do |t|
      t.text :pos
      t.text :neg
      t.integer :width
      t.integer :height
      t.integer :seed
      t.integer :cfg

      t.timestamps
    end
  end
end
