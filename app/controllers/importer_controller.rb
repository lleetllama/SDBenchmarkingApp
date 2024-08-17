require './lib/wrappers/comfy_api'
require 'fileutils'
require 'open-uri'
require 'mini_magick'

class ImporterController < ApplicationController
  def import_models
    models = Wrappers::ComfyApi.get_models

    test = ''
    models.each do |model|
      next if model.include?("XL") || model.include?("flux_1Dev")
      mod = SdModel.where(ckpt_path: model).first_or_create
      mod.import_metadata
    end

  end

  def fix_stuck_model_prompts
  #  model_prompts = SdModelPrompt.order(sd_model_id: :desc)
  #  # lets try to assign images before we regen.
  #  counter = 0

  #  model_prompts.each do |mod_prompt|

  #    if mod_prompt.sd_uuid.nil?
  #      mod_prompt.generate_image
  #      next
  #    end

  #    if model_prompt.img_url.nil?


  #    image_url = Wrappers::ComfyApi.get_sd_image(mod_prompt.sd_uuid)
  #    if image_url.nil?
  #      puts "This one is stuck"
  #      if mod_prompt.img_url.nil?
  #        mod_prompt.generate_image
  #        next
  #      else
  #        image_url = mod_prompt.img_url
  #      end
  #    end

  #    counter += 1

  #    # Parse the URL to extract the query parameters
  #    uri = URI.parse(image_url)
  #    params = URI.decode_www_form(uri.query).to_h
  #    # Define the save paths, ensuring the subfolder structure is respected
  #    original_save_path = Rails.root.join('app', 'assets', 'images', "#{mod_prompt.sd_model.id.to_s}-#{mod_prompt.sd_prompt.id.to_s}.png")
  #    thumbnail_save_path = Rails.root.join('app', 'assets', 'images', "#{mod_prompt.sd_model.id.to_s}-#{mod_prompt.sd_prompt.id.to_s}-thumb.png")
  #    # Ensure the directory exists before saving
  #    FileUtils.mkdir_p(File.dirname(original_save_path))
  #    FileUtils.mkdir_p(File.dirname(thumbnail_save_path))
  #    # Download the image and save it to the specified path
  #    File.open(original_save_path, 'wb') do |file|
  #      file.write(URI.open(image_url).read)
  #    end
  #    # Open the saved image with MiniMagick
  #    image = MiniMagick::Image.open(original_save_path)
  #    # Resize the image to 25% of its original size
  #    image.resize "40%"
  #    # Save the resized image as a thumbnail
  #    image.write(thumbnail_save_path)
  #    mod_prompt.img_url = "#{mod_prompt.sd_model.id.to_s}-#{mod_prompt.sd_prompt.id.to_s}"
  #    mod_prompt.save
  #  end



  #  flash.now[:success] = "Imported #{counter} image(s) successfully!"
  end

  def delete_all_model_prompts
    SdModelPrompt.all.each do |prompt|
      prompt.sd_uuid = nil
      prompt.img_url = nil
      prompt.save
    end
  end

  def delete_all_models
    SdModel.all.destroy_all
  end

  def import_metadata
    img_files = Dir.glob("#{ENV['MODEL_DIR']}/*.png") + Dir.glob("#{ENV['MODEL_DIR']}/**/*.png")
    img_files = img_files + Dir.glob("#{ENV['MODEL_DIR']}/*.jpeg") + Dir.glob("#{ENV['MODEL_DIR']}/**/*.jpeg")
    # Define the destination directory
    dest_dir = "C:/Users/timab/RubymineProjects/SDBenchmarkingApp/app/assets/images"

    # Iterate over each image file
    img_files.each do |filename|
      # Get the base name of the file (without the directory path)
      base_name = File.basename(filename)

      # Define the destination path for the file (in the destination directory)
      dest_path = File.join(dest_dir, base_name)

      # Copy the file to the destination directory
      FileUtils.cp(filename, dest_path)
    end
  end
end



#   require 'mini_magick'
#
#   # Find all image files (jpeg and png) that do not have "-thumb" in their name
#   image_files = Dir.glob("*.{jpeg,png}").reject { |file| file.include?("-thumb") }
#
#   image_files.each do |image_path|
#     # Extract the filename and create a new filename with "-thumb" appended
#     filename = File.basename(image_path)
#     thumb_filename = filename.sub(/\.(jpeg|png)$/i, '-thumb.\1')
#     thumb_path = File.join(File.dirname(image_path), thumb_filename)
#
#     # Open the image with MiniMagick
#     image = MiniMagick::Image.open(image_path)
#
#     # Resize the image to 25% of its original size
#     image.resize "40%"
#
#     # Save the resized image as a thumbnail in the same directory
#     image.write(thumb_path)
#
#     puts "Thumbnail created: #{thumb_path}"
#   end