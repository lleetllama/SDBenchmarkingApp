class AddSampleImageUrlToSdPrompts < ActiveRecord::Migration[7.1]
  def change
    add_column :sd_prompts, :sample_image_url, :string
  end
end
