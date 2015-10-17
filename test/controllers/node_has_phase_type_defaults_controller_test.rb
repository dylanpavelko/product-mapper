require 'test_helper'

class NodeHasPhaseTypeDefaultsControllerTest < ActionController::TestCase
  setup do
    @node_has_phase_type_default = node_has_phase_type_defaults(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:node_has_phase_type_defaults)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create node_has_phase_type_default" do
    assert_difference('NodeHasPhaseTypeDefault.count') do
      post :create, node_has_phase_type_default: { node_id: @node_has_phase_type_default.node_id, phase_type_default_id: @node_has_phase_type_default.phase_type_default_id }
    end

    assert_redirected_to node_has_phase_type_default_path(assigns(:node_has_phase_type_default))
  end

  test "should show node_has_phase_type_default" do
    get :show, id: @node_has_phase_type_default
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @node_has_phase_type_default
    assert_response :success
  end

  test "should update node_has_phase_type_default" do
    patch :update, id: @node_has_phase_type_default, node_has_phase_type_default: { node_id: @node_has_phase_type_default.node_id, phase_type_default_id: @node_has_phase_type_default.phase_type_default_id }
    assert_redirected_to node_has_phase_type_default_path(assigns(:node_has_phase_type_default))
  end

  test "should destroy node_has_phase_type_default" do
    assert_difference('NodeHasPhaseTypeDefault.count', -1) do
      delete :destroy, id: @node_has_phase_type_default
    end

    assert_redirected_to node_has_phase_type_defaults_path
  end
end
