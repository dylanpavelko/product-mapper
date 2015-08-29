require 'test_helper'

class GitHubReposControllerTest < ActionController::TestCase
  setup do
    @git_hub_repo = git_hub_repos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:git_hub_repos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create git_hub_repo" do
    assert_difference('GitHubRepo.count') do
      post :create, git_hub_repo: { node_id: @git_hub_repo.node_id, repo: @git_hub_repo.repo, user_id: @git_hub_repo.user_id }
    end

    assert_redirected_to git_hub_repo_path(assigns(:git_hub_repo))
  end

  test "should show git_hub_repo" do
    get :show, id: @git_hub_repo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @git_hub_repo
    assert_response :success
  end

  test "should update git_hub_repo" do
    patch :update, id: @git_hub_repo, git_hub_repo: { node_id: @git_hub_repo.node_id, repo: @git_hub_repo.repo, user_id: @git_hub_repo.user_id }
    assert_redirected_to git_hub_repo_path(assigns(:git_hub_repo))
  end

  test "should destroy git_hub_repo" do
    assert_difference('GitHubRepo.count', -1) do
      delete :destroy, id: @git_hub_repo
    end

    assert_redirected_to git_hub_repos_path
  end
end
