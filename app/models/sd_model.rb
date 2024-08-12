class SdModel < ApplicationRecord
  has_many :sd_model_prompts
  has_many :sd_prompts, through: :sd_model_prompts
  after_create :associate_with_prompts

  def associate_with_prompts
    prompts = SdPrompt.all
    prompts.each do |prompt|
      SdModelPrompt.where(sd_prompt: prompt, sd_model: self).first_or_create
    end
  end
end
