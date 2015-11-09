require 'test_helper'

class UserHasRoleForNodesControllerTest < ActionController::TestCase
  setup do
    @user_has_role_for_node = user_has_role_for_nodes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_has_role_for_nodes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_has_role_for_node" do
    assert_difference('UserHasRoleForNode.count') do
      post :create, user_has_role_for_node: { node_id: @user_has_role_for_node.node_id, role_id: @user_has_role_for_node.role_id, user_id: @user_has_role_for_node.user_id }
    end

    assert_redirected_to user_has_role_for_node_path(assigns(:user_has_role_for_node))
  end

  test "should show user_has_role_for_node" do
    get :show, id: @user_has_role_for_node
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_has_role_for_node
    assert_response :success
  end

  test "should update user_has_role_for_node" do
    patch :update, id: @user_has_role_for_node, user_has_role_for_node: { node_id: @user_has_role_for_node.node_id, role_id: @user_has_role_for_node.role_id, user_id: @user_has_role_for_node.user_id }
    assert_redirected_to user_has_role_for_node_path(assigns(:user_has_role_for_node))
  end

  test "should destroy user_has_role_for_node" do
    assert_difference('UserHasRoleForNode.count', -1) do
      delete :destroy, id: @user_has_role_for_node
    end

    assert_redirected_to user_has_role_for_nodes_path
  end
end
