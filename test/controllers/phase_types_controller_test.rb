require 'test_helper'

class PhaseTypesControllerTest < ActionController::TestCase
  setup do
    @phase_type = phase_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:phase_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create phase_type" do
    assert_difference('PhaseType.count') do
      post :create, phase_type: { name: @phase_type.name }
    end

    assert_redirected_to phase_type_path(assigns(:phase_type))
  end

  test "should show phase_type" do
    get :show, id: @phase_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @phase_type
    assert_response :success
  end

  test "should update phase_type" do
    patch :update, id: @phase_type, phase_type: { name: @phase_type.name }
    assert_redirected_to phase_type_path(assigns(:phase_type))
  end

  test "should destroy phase_type" do
    assert_difference('PhaseType.count', -1) do
      delete :destroy, id: @phase_type
    end

    assert_redirected_to phase_types_path
  end
end
