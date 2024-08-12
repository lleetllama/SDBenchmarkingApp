class SdModelPrompt < ApplicationRecord
  belongs_to :sd_model
  belongs_to :sd_prompt
end
