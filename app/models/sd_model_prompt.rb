require './lib/wrappers/comfy_api'
require 'fileutils'
require 'open-uri'
require 'mini_magick'
class SdModelPrompt < ApplicationRecord
  belongs_to :sd_model
  belongs_to :sd_prompt


  def full_image
    if sd_uuid.nil?
      generate_image
      return "not_found"
    end
    # do we have a url?
    if self.img_url.nil?
      image_url = Wrappers::ComfyApi.get_sd_image(mod_prompt.sd_uuid)
      if image_url.nil?
        # the file doesnt exist yet (or needs regenerated)
        return "not_found"
      else
        # file does exist so we should import it
        import_image
      end
    else
      # there is already a url. does it start with http?
      if img_url.include?("http")
        # this was the old way. i would rather regen than deal with this.
        self.img_url = nil
        return "not_found"
      end
    end

    self.img_url
  end

  def thumbnail
    full_image + "-thumb"
  end

  def import_image
    image_url = Wrappers::ComfyApi.get_sd_image(mod_prompt.sd_uuid)

    if image_url.nil?
      self.generate_image
      return
    end

    # Parse the URL to extract the query parameters
    uri = URI.parse(image_url)
    params = URI.decode_www_form(uri.query).to_h
    # Define the save paths, ensuring the subfolder structure is respected
    original_save_path = Rails.root.join('app', 'assets', 'images', "#{self.sd_model.id.to_s}-#{self.sd_prompt.id.to_s}.png")
    thumbnail_save_path = Rails.root.join('app', 'assets', 'images', "#{self.sd_model.id.to_s}-#{self.sd_prompt.id.to_s}-thumb.png")
    # Ensure the directory exists before saving
    FileUtils.mkdir_p(File.dirname(original_save_path))
    FileUtils.mkdir_p(File.dirname(thumbnail_save_path))
    # Download the image and save it to the specified path
    File.open(original_save_path, 'wb') do |file|
      file.write(URI.open(image_url).read)
    end
    # Open the saved image with MiniMagick
    image = MiniMagick::Image.open(original_save_path)
    # Resize the image to 25% of its original size
    image.resize "40%"
    # Save the resized image as a thumbnail
    image.write(thumbnail_save_path)
    self.img_url = "#{self.sd_model.id.to_s}-#{self.sd_prompt.id.to_s}"
    self.save
  end


  def generate_image
    comfy = Wrappers::ComfyApi

    # pausing due to BSOD issues
    if sd_model.ckpt_path.include? "XL"
      return
    end

    vae =
      if sd_model.ckpt_path.include? "XL"
        "sdxl_vae.safetensors"
      else
        "MoistMix.vae.pt"
      end

    params = {
      seed: sd_prompt.seed,
      checkpoint: sd_model.ckpt_path,
      width: sd_prompt.width,
      height: sd_prompt.height,
      pos_prompt: sd_prompt.pos,
      neg_prompt: sd_prompt.neg,
      vae: vae
    }

    res = comfy.txt_to_img_ws(params)
    self.sd_uuid = res["prompt_id"]
    self.save
  end
end
