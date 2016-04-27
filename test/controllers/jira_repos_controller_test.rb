require 'test_helper'

class JiraReposControllerTest < ActionController::TestCase
  setup do
    @jira_repo = jira_repos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:jira_repos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create jira_repo" do
    assert_difference('JiraRepo.count') do
      post :create, jira_repo: { name: @jira_repo.name, url: @jira_repo.url }
    end

    assert_redirected_to jira_repo_path(assigns(:jira_repo))
  end

  test "should show jira_repo" do
    get :show, id: @jira_repo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @jira_repo
    assert_response :success
  end

  test "should update jira_repo" do
    patch :update, id: @jira_repo, jira_repo: { name: @jira_repo.name, url: @jira_repo.url }
    assert_redirected_to jira_repo_path(assigns(:jira_repo))
  end

  test "should destroy jira_repo" do
    assert_difference('JiraRepo.count', -1) do
      delete :destroy, id: @jira_repo
    end

    assert_redirected_to jira_repos_path
  end
end
