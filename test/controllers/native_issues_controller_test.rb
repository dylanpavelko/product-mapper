require 'test_helper'

class NativeIssuesControllerTest < ActionController::TestCase
  setup do
    @native_issue = native_issues(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:native_issues)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create native_issue" do
    assert_difference('NativeIssue.count') do
      post :create, native_issue: { close_without_resolution: @native_issue.close_without_resolution, description: @native_issue.description, enhancement: @native_issue.enhancement, issue_with_id: @native_issue.issue_with_id, resolved_with_id: @native_issue.resolved_with_id, summary: @native_issue.summary }
    end

    assert_redirected_to native_issue_path(assigns(:native_issue))
  end

  test "should show native_issue" do
    get :show, id: @native_issue
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @native_issue
    assert_response :success
  end

  test "should update native_issue" do
    patch :update, id: @native_issue, native_issue: { close_without_resolution: @native_issue.close_without_resolution, description: @native_issue.description, enhancement: @native_issue.enhancement, issue_with_id: @native_issue.issue_with_id, resolved_with_id: @native_issue.resolved_with_id, summary: @native_issue.summary }
    assert_redirected_to native_issue_path(assigns(:native_issue))
  end

  test "should destroy native_issue" do
    assert_difference('NativeIssue.count', -1) do
      delete :destroy, id: @native_issue
    end

    assert_redirected_to native_issues_path
  end
end
