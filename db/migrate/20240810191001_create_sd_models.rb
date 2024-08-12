class CreateSdModels < ActiveRecord::Migration[7.1]
  def change
    create_table :sd_models do |t|
      t.string :name
      t.text :description
      t.string :ckpt_path

      t.timestamps
    end
  end
end
