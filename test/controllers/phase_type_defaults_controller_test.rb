require 'test_helper'

class PhaseTypeDefaultsControllerTest < ActionController::TestCase
  setup do
    @phase_type_default = phase_type_defaults(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:phase_type_defaults)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create phase_type_default" do
    assert_difference('PhaseTypeDefault.count') do
      post :create, phase_type_default: {  }
    end

    assert_redirected_to phase_type_default_path(assigns(:phase_type_default))
  end

  test "should show phase_type_default" do
    get :show, id: @phase_type_default
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @phase_type_default
    assert_response :success
  end

  test "should update phase_type_default" do
    patch :update, id: @phase_type_default, phase_type_default: {  }
    assert_redirected_to phase_type_default_path(assigns(:phase_type_default))
  end

  test "should destroy phase_type_default" do
    assert_difference('PhaseTypeDefault.count', -1) do
      delete :destroy, id: @phase_type_default
    end

    assert_redirected_to phase_type_defaults_path
  end
end
