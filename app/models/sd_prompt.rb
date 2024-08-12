class SdPrompt < ApplicationRecord
  has_many :sd_model_prompts
  has_many :sd_models, through: :sd_model_prompts
  after_create :associate_with_models

  def associate_with_models
    models = SdModel.all
    models.each do |model|
      SdModelPrompt.where(sd_prompt: self, sd_model: model).first_or_create
    end
  end
end
