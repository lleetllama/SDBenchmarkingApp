class SdModel < ApplicationRecord
  has_many :sd_model_prompts, dependent: :destroy
  has_many :sd_prompts, through: :sd_model_prompts
  after_create :associate_with_prompts
  after_create :import_metadata

  def import_metadata
    json_files = Dir.glob("#{ENV["MODEL_DIR"]}/*.json")
    json_files = json_files + Dir.glob("#{ENV["MODEL_DIR"]}/**/*.json")
    model_name = ckpt_path.split("\\").last.split(".").first

    json_file = json_files.find { |file| file.include?(model_name) }
    if json_file.nil?
      self.update(
        description: "N/A",
        name: model_name,
        sample_image_url: "#{model_name}.preview"
      )
      return
    end

    json_data = JSON.parse(File.read(json_file))
    self.update(
      description: json_data["ModelDescription"],
      name: json_data["ModelName"],
      sample_image_url: "#{model_name}.preview"
    )
  end

  def associate_with_prompts
    prompts = SdPrompt.all
    prompts.each do |prompt|
      SdModelPrompt.where(sd_prompt: prompt, sd_model: self).first_or_create
    end
  end
end
