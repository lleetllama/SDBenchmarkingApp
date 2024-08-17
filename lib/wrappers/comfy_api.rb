require "net/http"
require "json"
require "uri"
require "pry"

module Wrappers
  class ComfyApi
    class << self
      BASE_URL = ENV["COMFY_URL"]

      def queue_count
        uri = URI.parse("#{BASE_URL}/queue")
        response = Net::HTTP.get_response(uri)
        JSON.parse(response.body)["queue_pending"].count
      end

      def checkpoint_merge(checkpoint1, checkpoint2, output_checkpoint)
      end

      def get_models
        uri = URI.parse("#{BASE_URL}/object_info/CheckpointLoader")
        response = Net::HTTP.get_response(uri)
        JSON.parse(response.body)["CheckpointLoader"]["input"]["required"]["ckpt_name"].flatten
      end

      def get_vaes
        uri = URI.parse("#{BASE_URL}/object_info/VAELoader")
        response = Net::HTTP.get_response(uri)
        JSON.parse(response.body)["VAELoader"]["input"]["required"]["vae_name"].flatten
      end

      def get_samplers
        uri = URI.parse("#{BASE_URL}/object_info/KSampler")
        response = Net::HTTP.get_response(uri)
        JSON.parse(response.body)["KSampler"]["input"]["required"]["sampler_name"].flatten
      end

      def get_loras
        uri = URI.parse("#{BASE_URL}/object_info/LoraLoader")
        response = Net::HTTP.get_response(uri)
        JSON.parse(response.body)["LoraLoader"]["input"]["required"]["lora_name"].flatten
      end

      def checkpoint_blend(params)
        template_path = "./lib/templates/checkpoint_merge.json"
        template = File.read(template_path)
        json_data = JSON.parse(template)

        json_data["3"]["inputs"]["seed"] = params[:seed] || 1337
        json_data["3"]["inputs"]["steps"] = params[:steps] || 25

        json_data["3"]["inputs"]["scheduler"] = params[:scheduler] || "karras"
        json_data["3"]["inputs"]["sampler_name"] = params[:sampler_name] || "dpmpp_2m"

        json_data["4"]["inputs"]["ckpt_name"] = params[:checkpoint1]
        json_data["11"]["inputs"]["ckpt_name"] = params[:checkpoint2]

        json_data["5"]["inputs"]["width"] = params[:width] || 640
        json_data["5"]["inputs"]["height"] = params[:height] || 768
        json_data["5"]["inputs"]["batch_size"] = params[:batch_size] || 1

        json_data["6"]["inputs"]["text"] = params[:pos_prompt]
        json_data["7"]["inputs"]["text"] = params[:neg_prompt]

        first_model = json_data["4"]["inputs"]["ckpt_name"].split("\\").last.split(".").first
        second_model = json_data["11"]["inputs"]["ckpt_name"].split("\\").last.split(".").first

        json_data["9"]["inputs"]["filename_prefix"] = params[:prefix] || "#{first_model}-merge/#{second_model}"

        wrapped_payload = { "prompt" => json_data }
        response = send_prompt(wrapped_payload)
      end

      def txt_to_img_ws(params)
        template_path = "./lib/templates/txt_to_img.json"
        template = File.read(template_path)
        json_data = JSON.parse(template)
        json_data["3"]["inputs"]["seed"] = params[:seed] || 1337
        json_data["3"]["inputs"]["steps"] = params[:steps] || 30
        json_data["3"]["inputs"]["sampler_name"] = params[:sampler_name] || "dpmpp_2m"
        json_data["3"]["inputs"]["scheduler"] = params[:scheduler] || "karras"
        json_data["4"]["inputs"]["ckpt_name"] = params[:checkpoint]
        json_data["5"]["inputs"]["width"] = params[:width] || 832
        json_data["5"]["inputs"]["height"] = params[:height] || 1216
        json_data["6"]["inputs"]["text"] = params[:pos_prompt]
        json_data["7"]["inputs"]["text"] = params[:neg_prompt]

        json_data["11"]["inputs"]["vae_name"] = params[:vae] || "MoistMix.vae.pt"

        filename = json_data["4"]["inputs"]["ckpt_name"].split("\\").last.split(".").first
        json_data["9"]["inputs"]["filename_prefix"] = params[:prefix] || "BenchmarkEngine/#{filename}/img"
        # Wrap the payload inside another JSON object with the key "prompt"
        wrapped_payload = { "prompt" => json_data }
        response = send_prompt(wrapped_payload)
      end

      def get_sd_image(job_code)
        uri = URI.parse("#{BASE_URL}/history/#{job_code}")
        response = Net::HTTP.get_response(uri)
        begin
          parsed_response = JSON.parse(response.body)
          image_details = parsed_response[job_code]["outputs"]["9"]["images"].first
          return "#{BASE_URL}/view?filename=#{image_details["filename"]}&subfolder=#{image_details["subfolder"]}&type=#{image_details["type"]}"
        rescue
          nil
        end
      end

      def txt_to_img(params)
        template_path = "./lib/templates/txt_to_img.json"
        template = File.read(template_path)
        json_data = JSON.parse(template)

        # Replace placeholders with actual values
        json_data["3"]["inputs"]["seed"] = params[:seed] || 1337
        json_data["3"]["inputs"]["steps"] = params[:steps] || 30
        json_data["3"]["inputs"]["sampler_name"] = params[:sampler_name] || "dpmpp_2m"
        json_data["3"]["inputs"]["scheduler"] = params[:scheduler] || "karras"
        json_data["4"]["inputs"]["ckpt_name"] = params[:checkpoint]
        json_data["5"]["inputs"]["width"] = params[:width] || 832
        json_data["5"]["inputs"]["height"] = params[:height] || 1216
        json_data["6"]["inputs"]["text"] = params[:pos_prompt]
        json_data["7"]["inputs"]["text"] = params[:neg_prompt]

        filename = json_data["4"]["inputs"]["ckpt_name"].split("\\").last.split(".").first
        json_data["9"]["inputs"]["filename_prefix"] = params[:prefix] || "BenchmarkEngine/#{filename}/img"

        # Wrap the payload inside another JSON object with the key "prompt"
        wrapped_payload = { "prompt" => json_data }

        response = send_prompt(wrapped_payload)
      end

      def txt_to_img_lora(params)
        template_path = "./lib/templates/txt_to_img_lora.json"
        template = File.read(template_path)
        json_data = JSON.parse(template)

        # Replace placeholders with actual values
        json_data["3"]["inputs"]["seed"] = params[:seed] || 1337
        json_data["3"]["inputs"]["steps"] = params[:steps] || 30
        json_data["3"]["inputs"]["sampler_name"] = params[:sampler_name] || "dpmpp_2m"
        json_data["3"]["inputs"]["scheduler"] = params[:scheduler] || "karras"
        json_data["4"]["inputs"]["ckpt_name"] = params[:checkpoint]
        json_data["5"]["inputs"]["width"] = params[:width] || 832
        json_data["5"]["inputs"]["height"] = params[:height] || 1216
        json_data["6"]["inputs"]["text"] = params[:pos_prompt]
        json_data["7"]["inputs"]["text"] = params[:neg_prompt]

        json_data["15"]["inputs"]["lora_name"] = params[:lora]

        # Wrap the payload inside another JSON object with the key "prompt"
        wrapped_payload = { "prompt" => json_data }

        response = send_prompt(wrapped_payload)
      end

      private

      def send_prompt(json_data)
        uri = URI.parse("#{BASE_URL}/prompt")
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = uri.scheme == "https"

        request = Net::HTTP::Post.new(uri.request_uri, { 'Content-Type': "application/json" })
        request.body = json_data.to_json

        response = http.request(request)
        raise "Request failed with response: #{response.body}" unless response.is_a?(Net::HTTPSuccess)

        JSON.parse(response.body)
      end
    end
  end
end
