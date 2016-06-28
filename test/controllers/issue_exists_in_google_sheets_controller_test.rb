require 'test_helper'

class IssueExistsInGoogleSheetsControllerTest < ActionController::TestCase
  setup do
    @issue_exists_in_google_sheet = issue_exists_in_google_sheets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:issue_exists_in_google_sheets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create issue_exists_in_google_sheet" do
    assert_difference('IssueExistsInGoogleSheet.count') do
      post :create, issue_exists_in_google_sheet: { external_id: @issue_exists_in_google_sheet.external_id, google_sheet_id: @issue_exists_in_google_sheet.google_sheet_id, native_issue_id: @issue_exists_in_google_sheet.native_issue_id }
    end

    assert_redirected_to issue_exists_in_google_sheet_path(assigns(:issue_exists_in_google_sheet))
  end

  test "should show issue_exists_in_google_sheet" do
    get :show, id: @issue_exists_in_google_sheet
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @issue_exists_in_google_sheet
    assert_response :success
  end

  test "should update issue_exists_in_google_sheet" do
    patch :update, id: @issue_exists_in_google_sheet, issue_exists_in_google_sheet: { external_id: @issue_exists_in_google_sheet.external_id, google_sheet_id: @issue_exists_in_google_sheet.google_sheet_id, native_issue_id: @issue_exists_in_google_sheet.native_issue_id }
    assert_redirected_to issue_exists_in_google_sheet_path(assigns(:issue_exists_in_google_sheet))
  end

  test "should destroy issue_exists_in_google_sheet" do
    assert_difference('IssueExistsInGoogleSheet.count', -1) do
      delete :destroy, id: @issue_exists_in_google_sheet
    end

    assert_redirected_to issue_exists_in_google_sheets_path
  end
end
