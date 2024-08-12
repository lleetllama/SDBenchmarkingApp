require "test_helper"

class SdPromptsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sd_prompt = sd_prompts(:one)
  end

  test "should get index" do
    get sd_prompts_url
    assert_response :success
  end

  test "should get new" do
    get new_sd_prompt_url
    assert_response :success
  end

  test "should create sd_prompt" do
    assert_difference("SdPrompt.count") do
      post sd_prompts_url, params: { sd_prompt: { cfg: @sd_prompt.cfg, height: @sd_prompt.height, neg: @sd_prompt.neg, pos: @sd_prompt.pos, seed: @sd_prompt.seed, width: @sd_prompt.width } }
    end

    assert_redirected_to sd_prompt_url(SdPrompt.last)
  end

  test "should show sd_prompt" do
    get sd_prompt_url(@sd_prompt)
    assert_response :success
  end

  test "should get edit" do
    get edit_sd_prompt_url(@sd_prompt)
    assert_response :success
  end

  test "should update sd_prompt" do
    patch sd_prompt_url(@sd_prompt), params: { sd_prompt: { cfg: @sd_prompt.cfg, height: @sd_prompt.height, neg: @sd_prompt.neg, pos: @sd_prompt.pos, seed: @sd_prompt.seed, width: @sd_prompt.width } }
    assert_redirected_to sd_prompt_url(@sd_prompt)
  end

  test "should destroy sd_prompt" do
    assert_difference("SdPrompt.count", -1) do
      delete sd_prompt_url(@sd_prompt)
    end

    assert_redirected_to sd_prompts_url
  end
end
