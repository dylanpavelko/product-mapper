require 'test_helper'

class UserHasFavoriteNodesControllerTest < ActionController::TestCase
  setup do
    @user_has_favorite_node = user_has_favorite_nodes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_has_favorite_nodes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_has_favorite_node" do
    assert_difference('UserHasFavoriteNode.count') do
      post :create, user_has_favorite_node: { node_id: @user_has_favorite_node.node_id, user_id: @user_has_favorite_node.user_id }
    end

    assert_redirected_to user_has_favorite_node_path(assigns(:user_has_favorite_node))
  end

  test "should show user_has_favorite_node" do
    get :show, id: @user_has_favorite_node
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_has_favorite_node
    assert_response :success
  end

  test "should update user_has_favorite_node" do
    patch :update, id: @user_has_favorite_node, user_has_favorite_node: { node_id: @user_has_favorite_node.node_id, user_id: @user_has_favorite_node.user_id }
    assert_redirected_to user_has_favorite_node_path(assigns(:user_has_favorite_node))
  end

  test "should destroy user_has_favorite_node" do
    assert_difference('UserHasFavoriteNode.count', -1) do
      delete :destroy, id: @user_has_favorite_node
    end

    assert_redirected_to user_has_favorite_nodes_path
  end
end
