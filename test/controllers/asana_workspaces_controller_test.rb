require 'test_helper'

class AsanaWorkspacesControllerTest < ActionController::TestCase
  setup do
    @asana_workspace = asana_workspaces(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:asana_workspaces)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create asana_workspace" do
    assert_difference('AsanaWorkspace.count') do
      post :create, asana_workspace: { added_by_id: @asana_workspace.added_by_id, node_id: @asana_workspace.node_id, workspace: @asana_workspace.workspace }
    end

    assert_redirected_to asana_workspace_path(assigns(:asana_workspace))
  end

  test "should show asana_workspace" do
    get :show, id: @asana_workspace
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @asana_workspace
    assert_response :success
  end

  test "should update asana_workspace" do
    patch :update, id: @asana_workspace, asana_workspace: { added_by_id: @asana_workspace.added_by_id, node_id: @asana_workspace.node_id, workspace: @asana_workspace.workspace }
    assert_redirected_to asana_workspace_path(assigns(:asana_workspace))
  end

  test "should destroy asana_workspace" do
    assert_difference('AsanaWorkspace.count', -1) do
      delete :destroy, id: @asana_workspace
    end

    assert_redirected_to asana_workspaces_path
  end
end
