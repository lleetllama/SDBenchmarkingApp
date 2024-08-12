require "application_system_test_case"

class SdModelPromptsTest < ApplicationSystemTestCase
  setup do
    @sd_model_prompt = sd_model_prompts(:one)
  end

  test "visiting the index" do
    visit sd_model_prompts_url
    assert_selector "h1", text: "Sd model prompts"
  end

  test "should create sd model prompt" do
    visit sd_model_prompts_url
    click_on "New sd model prompt"

    fill_in "Img url", with: @sd_model_prompt.img_url
    fill_in "Sd model", with: @sd_model_prompt.sd_model_id
    fill_in "Sd prompt", with: @sd_model_prompt.sd_prompt_id
    fill_in "Sd uuid", with: @sd_model_prompt.sd_uuid
    click_on "Create Sd model prompt"

    assert_text "Sd model prompt was successfully created"
    click_on "Back"
  end

  test "should update Sd model prompt" do
    visit sd_model_prompt_url(@sd_model_prompt)
    click_on "Edit this sd model prompt", match: :first

    fill_in "Img url", with: @sd_model_prompt.img_url
    fill_in "Sd model", with: @sd_model_prompt.sd_model_id
    fill_in "Sd prompt", with: @sd_model_prompt.sd_prompt_id
    fill_in "Sd uuid", with: @sd_model_prompt.sd_uuid
    click_on "Update Sd model prompt"

    assert_text "Sd model prompt was successfully updated"
    click_on "Back"
  end

  test "should destroy Sd model prompt" do
    visit sd_model_prompt_url(@sd_model_prompt)
    click_on "Destroy this sd model prompt", match: :first

    assert_text "Sd model prompt was successfully destroyed"
  end
end
