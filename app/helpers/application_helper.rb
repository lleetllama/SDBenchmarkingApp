module ApplicationHelper

  def sample_image(model_name)
    "https://picsum.photos/seed/picsum/640/768"
  end

  def tall_wide_or_square(mod_prompt)
    w = mod_prompt.sd_prompt.width
    h = mod_prompt.sd_prompt.height
    if w > h
      return [240, 340]
    elsif h > w
      return [340, 240]
    else
      return [340, 340]
    end
  end
end
