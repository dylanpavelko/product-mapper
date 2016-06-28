require 'test_helper'

class GoogleSheetHasMappingsControllerTest < ActionController::TestCase
  setup do
    @google_sheet_has_mapping = google_sheet_has_mappings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:google_sheet_has_mappings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create google_sheet_has_mapping" do
    assert_difference('GoogleSheetHasMapping.count') do
      post :create, google_sheet_has_mapping: { column_name: @google_sheet_has_mapping.column_name, column_number: @google_sheet_has_mapping.column_number, data_type: @google_sheet_has_mapping.data_type, google_sheet_id: @google_sheet_has_mapping.google_sheet_id }
    end

    assert_redirected_to google_sheet_has_mapping_path(assigns(:google_sheet_has_mapping))
  end

  test "should show google_sheet_has_mapping" do
    get :show, id: @google_sheet_has_mapping
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @google_sheet_has_mapping
    assert_response :success
  end

  test "should update google_sheet_has_mapping" do
    patch :update, id: @google_sheet_has_mapping, google_sheet_has_mapping: { column_name: @google_sheet_has_mapping.column_name, column_number: @google_sheet_has_mapping.column_number, data_type: @google_sheet_has_mapping.data_type, google_sheet_id: @google_sheet_has_mapping.google_sheet_id }
    assert_redirected_to google_sheet_has_mapping_path(assigns(:google_sheet_has_mapping))
  end

  test "should destroy google_sheet_has_mapping" do
    assert_difference('GoogleSheetHasMapping.count', -1) do
      delete :destroy, id: @google_sheet_has_mapping
    end

    assert_redirected_to google_sheet_has_mappings_path
  end
end
