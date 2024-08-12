require "test_helper"

class SdModelPromptsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sd_model_prompt = sd_model_prompts(:one)
  end

  test "should get index" do
    get sd_model_prompts_url
    assert_response :success
  end

  test "should get new" do
    get new_sd_model_prompt_url
    assert_response :success
  end

  test "should create sd_model_prompt" do
    assert_difference("SdModelPrompt.count") do
      post sd_model_prompts_url, params: { sd_model_prompt: { img_url: @sd_model_prompt.img_url, sd_model_id: @sd_model_prompt.sd_model_id, sd_prompt_id: @sd_model_prompt.sd_prompt_id, sd_uuid: @sd_model_prompt.sd_uuid } }
    end

    assert_redirected_to sd_model_prompt_url(SdModelPrompt.last)
  end

  test "should show sd_model_prompt" do
    get sd_model_prompt_url(@sd_model_prompt)
    assert_response :success
  end

  test "should get edit" do
    get edit_sd_model_prompt_url(@sd_model_prompt)
    assert_response :success
  end

  test "should update sd_model_prompt" do
    patch sd_model_prompt_url(@sd_model_prompt), params: { sd_model_prompt: { img_url: @sd_model_prompt.img_url, sd_model_id: @sd_model_prompt.sd_model_id, sd_prompt_id: @sd_model_prompt.sd_prompt_id, sd_uuid: @sd_model_prompt.sd_uuid } }
    assert_redirected_to sd_model_prompt_url(@sd_model_prompt)
  end

  test "should destroy sd_model_prompt" do
    assert_difference("SdModelPrompt.count", -1) do
      delete sd_model_prompt_url(@sd_model_prompt)
    end

    assert_redirected_to sd_model_prompts_url
  end
end
