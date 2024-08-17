require "test_helper"

class ImporterControllerTest < ActionDispatch::IntegrationTest
  test "should get import_models" do
    get importer_import_models_url
    assert_response :success
  end

  test "should get import_metadata" do
    get importer_import_metadata_url
    assert_response :success
  end
end
