require 'test_helper'

class GitHubAccountsControllerTest < ActionController::TestCase
  setup do
    @git_hub_account = git_hub_accounts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:git_hub_accounts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create git_hub_account" do
    assert_difference('GitHubAccount.count') do
      post :create, git_hub_account: { oauth: @git_hub_account.oauth, user_id: @git_hub_account.user_id }
    end

    assert_redirected_to git_hub_account_path(assigns(:git_hub_account))
  end

  test "should show git_hub_account" do
    get :show, id: @git_hub_account
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @git_hub_account
    assert_response :success
  end

  test "should update git_hub_account" do
    patch :update, id: @git_hub_account, git_hub_account: { oauth: @git_hub_account.oauth, user_id: @git_hub_account.user_id }
    assert_redirected_to git_hub_account_path(assigns(:git_hub_account))
  end

  test "should destroy git_hub_account" do
    assert_difference('GitHubAccount.count', -1) do
      delete :destroy, id: @git_hub_account
    end

    assert_redirected_to git_hub_accounts_path
  end
end
