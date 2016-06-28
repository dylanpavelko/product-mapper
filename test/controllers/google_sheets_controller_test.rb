require 'test_helper'

class GoogleSheetsControllerTest < ActionController::TestCase
  setup do
    @google_sheet = google_sheets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:google_sheets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create google_sheet" do
    assert_difference('GoogleSheet.count') do
      post :create, google_sheet: { key: @google_sheet.key }
    end

    assert_redirected_to google_sheet_path(assigns(:google_sheet))
  end

  test "should show google_sheet" do
    get :show, id: @google_sheet
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @google_sheet
    assert_response :success
  end

  test "should update google_sheet" do
    patch :update, id: @google_sheet, google_sheet: { key: @google_sheet.key }
    assert_redirected_to google_sheet_path(assigns(:google_sheet))
  end

  test "should destroy google_sheet" do
    assert_difference('GoogleSheet.count', -1) do
      delete :destroy, id: @google_sheet
    end

    assert_redirected_to google_sheets_path
  end
end
