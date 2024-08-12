class AddNameToSdPrompts < ActiveRecord::Migration[7.1]
  def change
    add_column :sd_prompts, :name, :string
  end
end
