require 'test_helper'

class JiraIssuesControllerTest < ActionController::TestCase
  setup do
    @jira_issue = jira_issues(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:jira_issues)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create jira_issue" do
    assert_difference('JiraIssue.count') do
      post :create, jira_issue: { jira_repo_id: @jira_issue.jira_repo_id, key: @jira_issue.key, summary: @jira_issue.summary }
    end

    assert_redirected_to jira_issue_path(assigns(:jira_issue))
  end

  test "should show jira_issue" do
    get :show, id: @jira_issue
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @jira_issue
    assert_response :success
  end

  test "should update jira_issue" do
    patch :update, id: @jira_issue, jira_issue: { jira_repo_id: @jira_issue.jira_repo_id, key: @jira_issue.key, summary: @jira_issue.summary }
    assert_redirected_to jira_issue_path(assigns(:jira_issue))
  end

  test "should destroy jira_issue" do
    assert_difference('JiraIssue.count', -1) do
      delete :destroy, id: @jira_issue
    end

    assert_redirected_to jira_issues_path
  end
end
