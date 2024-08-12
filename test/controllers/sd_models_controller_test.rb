require "test_helper"

class SdModelsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sd_model = sd_models(:one)
  end

  test "should get index" do
    get sd_models_url
    assert_response :success
  end

  test "should get new" do
    get new_sd_model_url
    assert_response :success
  end

  test "should create sd_model" do
    assert_difference("SdModel.count") do
      post sd_models_url, params: { sd_model: { ckpt_path: @sd_model.ckpt_path, description: @sd_model.description, name: @sd_model.name } }
    end

    assert_redirected_to sd_model_url(SdModel.last)
  end

  test "should show sd_model" do
    get sd_model_url(@sd_model)
    assert_response :success
  end

  test "should get edit" do
    get edit_sd_model_url(@sd_model)
    assert_response :success
  end

  test "should update sd_model" do
    patch sd_model_url(@sd_model), params: { sd_model: { ckpt_path: @sd_model.ckpt_path, description: @sd_model.description, name: @sd_model.name } }
    assert_redirected_to sd_model_url(@sd_model)
  end

  test "should destroy sd_model" do
    assert_difference("SdModel.count", -1) do
      delete sd_model_url(@sd_model)
    end

    assert_redirected_to sd_models_url
  end
end
