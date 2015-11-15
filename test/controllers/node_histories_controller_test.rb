require 'test_helper'

class NodeHistoriesControllerTest < ActionController::TestCase
  setup do
    @node_history = node_histories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:node_histories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create node_history" do
    assert_difference('NodeHistory.count') do
      post :create, node_history: { log: @node_history.log, node_id: @node_history.node_id, other_node_id: @node_history.other_node_id, other_reference_id: @node_history.other_reference_id, type: @node_history.type, user_id: @node_history.user_id }
    end

    assert_redirected_to node_history_path(assigns(:node_history))
  end

  test "should show node_history" do
    get :show, id: @node_history
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @node_history
    assert_response :success
  end

  test "should update node_history" do
    patch :update, id: @node_history, node_history: { log: @node_history.log, node_id: @node_history.node_id, other_node_id: @node_history.other_node_id, other_reference_id: @node_history.other_reference_id, type: @node_history.type, user_id: @node_history.user_id }
    assert_redirected_to node_history_path(assigns(:node_history))
  end

  test "should destroy node_history" do
    assert_difference('NodeHistory.count', -1) do
      delete :destroy, id: @node_history
    end

    assert_redirected_to node_histories_path
  end
end
