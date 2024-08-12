class AddSampleImageUrlAndCivitaiLinkToSdModels < ActiveRecord::Migration[7.1]
  def change
    add_column :sd_models, :sample_image_url, :string
    add_column :sd_models, :civitai_link, :string
  end
end
