require "application_system_test_case"

class SdPromptsTest < ApplicationSystemTestCase
  setup do
    @sd_prompt = sd_prompts(:one)
  end

  test "visiting the index" do
    visit sd_prompts_url
    assert_selector "h1", text: "Sd prompts"
  end

  test "should create sd prompt" do
    visit sd_prompts_url
    click_on "New sd prompt"

    fill_in "Cfg", with: @sd_prompt.cfg
    fill_in "Height", with: @sd_prompt.height
    fill_in "Neg", with: @sd_prompt.neg
    fill_in "Pos", with: @sd_prompt.pos
    fill_in "Seed", with: @sd_prompt.seed
    fill_in "Width", with: @sd_prompt.width
    click_on "Create Sd prompt"

    assert_text "Sd prompt was successfully created"
    click_on "Back"
  end

  test "should update Sd prompt" do
    visit sd_prompt_url(@sd_prompt)
    click_on "Edit this sd prompt", match: :first

    fill_in "Cfg", with: @sd_prompt.cfg
    fill_in "Height", with: @sd_prompt.height
    fill_in "Neg", with: @sd_prompt.neg
    fill_in "Pos", with: @sd_prompt.pos
    fill_in "Seed", with: @sd_prompt.seed
    fill_in "Width", with: @sd_prompt.width
    click_on "Update Sd prompt"

    assert_text "Sd prompt was successfully updated"
    click_on "Back"
  end

  test "should destroy Sd prompt" do
    visit sd_prompt_url(@sd_prompt)
    click_on "Destroy this sd prompt", match: :first

    assert_text "Sd prompt was successfully destroyed"
  end
end
