require 'test_helper'

class GitHubIssuesControllerTest < ActionController::TestCase
  setup do
    @git_hub_issue = git_hub_issues(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:git_hub_issues)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create git_hub_issue" do
    assert_difference('GitHubIssue.count') do
      post :create, git_hub_issue: { body: @git_hub_issue.body, closed: @git_hub_issue.closed, created: @git_hub_issue.created, gitHubID: @git_hub_issue.gitHubID, node_id: @git_hub_issue.node_id, number: @git_hub_issue.number, repo_id: @git_hub_issue.repo_id, title: @git_hub_issue.title, updated: @git_hub_issue.updated }
    end

    assert_redirected_to git_hub_issue_path(assigns(:git_hub_issue))
  end

  test "should show git_hub_issue" do
    get :show, id: @git_hub_issue
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @git_hub_issue
    assert_response :success
  end

  test "should update git_hub_issue" do
    patch :update, id: @git_hub_issue, git_hub_issue: { body: @git_hub_issue.body, closed: @git_hub_issue.closed, created: @git_hub_issue.created, gitHubID: @git_hub_issue.gitHubID, node_id: @git_hub_issue.node_id, number: @git_hub_issue.number, repo_id: @git_hub_issue.repo_id, title: @git_hub_issue.title, updated: @git_hub_issue.updated }
    assert_redirected_to git_hub_issue_path(assigns(:git_hub_issue))
  end

  test "should destroy git_hub_issue" do
    assert_difference('GitHubIssue.count', -1) do
      delete :destroy, id: @git_hub_issue
    end

    assert_redirected_to git_hub_issues_path
  end
end
