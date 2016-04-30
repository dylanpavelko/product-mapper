require 'test_helper'

class NativeIssueHasImpactsControllerTest < ActionController::TestCase
  setup do
    @native_issue_has_impact = native_issue_has_impacts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:native_issue_has_impacts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create native_issue_has_impact" do
    assert_difference('NativeIssueHasImpact.count') do
      post :create, native_issue_has_impact: { customer_id: @native_issue_has_impact.customer_id, impact: @native_issue_has_impact.impact, native_issue_id: @native_issue_has_impact.native_issue_id }
    end

    assert_redirected_to native_issue_has_impact_path(assigns(:native_issue_has_impact))
  end

  test "should show native_issue_has_impact" do
    get :show, id: @native_issue_has_impact
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @native_issue_has_impact
    assert_response :success
  end

  test "should update native_issue_has_impact" do
    patch :update, id: @native_issue_has_impact, native_issue_has_impact: { customer_id: @native_issue_has_impact.customer_id, impact: @native_issue_has_impact.impact, native_issue_id: @native_issue_has_impact.native_issue_id }
    assert_redirected_to native_issue_has_impact_path(assigns(:native_issue_has_impact))
  end

  test "should destroy native_issue_has_impact" do
    assert_difference('NativeIssueHasImpact.count', -1) do
      delete :destroy, id: @native_issue_has_impact
    end

    assert_redirected_to native_issue_has_impacts_path
  end
end
