require "application_system_test_case"

class SdModelsTest < ApplicationSystemTestCase
  setup do
    @sd_model = sd_models(:one)
  end

  test "visiting the index" do
    visit sd_models_url
    assert_selector "h1", text: "Sd models"
  end

  test "should create sd model" do
    visit sd_models_url
    click_on "New sd model"

    fill_in "Ckpt path", with: @sd_model.ckpt_path
    fill_in "Description", with: @sd_model.description
    fill_in "Name", with: @sd_model.name
    click_on "Create Sd model"

    assert_text "Sd model was successfully created"
    click_on "Back"
  end

  test "should update Sd model" do
    visit sd_model_url(@sd_model)
    click_on "Edit this sd model", match: :first

    fill_in "Ckpt path", with: @sd_model.ckpt_path
    fill_in "Description", with: @sd_model.description
    fill_in "Name", with: @sd_model.name
    click_on "Update Sd model"

    assert_text "Sd model was successfully updated"
    click_on "Back"
  end

  test "should destroy Sd model" do
    visit sd_model_url(@sd_model)
    click_on "Destroy this sd model", match: :first

    assert_text "Sd model was successfully destroyed"
  end
end
