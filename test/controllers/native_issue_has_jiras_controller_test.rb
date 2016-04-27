require 'test_helper'

class NativeIssueHasJirasControllerTest < ActionController::TestCase
  setup do
    @native_issue_has_jira = native_issue_has_jiras(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:native_issue_has_jiras)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create native_issue_has_jira" do
    assert_difference('NativeIssueHasJira.count') do
      post :create, native_issue_has_jira: { jira_id: @native_issue_has_jira.jira_id, native_issue_id: @native_issue_has_jira.native_issue_id }
    end

    assert_redirected_to native_issue_has_jira_path(assigns(:native_issue_has_jira))
  end

  test "should show native_issue_has_jira" do
    get :show, id: @native_issue_has_jira
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @native_issue_has_jira
    assert_response :success
  end

  test "should update native_issue_has_jira" do
    patch :update, id: @native_issue_has_jira, native_issue_has_jira: { jira_id: @native_issue_has_jira.jira_id, native_issue_id: @native_issue_has_jira.native_issue_id }
    assert_redirected_to native_issue_has_jira_path(assigns(:native_issue_has_jira))
  end

  test "should destroy native_issue_has_jira" do
    assert_difference('NativeIssueHasJira.count', -1) do
      delete :destroy, id: @native_issue_has_jira
    end

    assert_redirected_to native_issue_has_jiras_path
  end
end
