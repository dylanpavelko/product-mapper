require 'test_helper'

class PhaseTypeDefaultHasPhyaseTypesControllerTest < ActionController::TestCase
  setup do
    @phase_type_default_has_phyase_type = phase_type_default_has_phyase_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:phase_type_default_has_phyase_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create phase_type_default_has_phyase_type" do
    assert_difference('PhaseTypeDefaultHasPhyaseType.count') do
      post :create, phase_type_default_has_phyase_type: { phase_type_default_id: @phase_type_default_has_phyase_type.phase_type_default_id, phase_type_id: @phase_type_default_has_phyase_type.phase_type_id }
    end

    assert_redirected_to phase_type_default_has_phyase_type_path(assigns(:phase_type_default_has_phyase_type))
  end

  test "should show phase_type_default_has_phyase_type" do
    get :show, id: @phase_type_default_has_phyase_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @phase_type_default_has_phyase_type
    assert_response :success
  end

  test "should update phase_type_default_has_phyase_type" do
    patch :update, id: @phase_type_default_has_phyase_type, phase_type_default_has_phyase_type: { phase_type_default_id: @phase_type_default_has_phyase_type.phase_type_default_id, phase_type_id: @phase_type_default_has_phyase_type.phase_type_id }
    assert_redirected_to phase_type_default_has_phyase_type_path(assigns(:phase_type_default_has_phyase_type))
  end

  test "should destroy phase_type_default_has_phyase_type" do
    assert_difference('PhaseTypeDefaultHasPhyaseType.count', -1) do
      delete :destroy, id: @phase_type_default_has_phyase_type
    end

    assert_redirected_to phase_type_default_has_phyase_types_path
  end
end
