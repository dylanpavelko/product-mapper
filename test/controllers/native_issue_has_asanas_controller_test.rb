require 'test_helper'

class NativeIssueHasAsanasControllerTest < ActionController::TestCase
  setup do
    @native_issue_has_asana = native_issue_has_asanas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:native_issue_has_asanas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create native_issue_has_asana" do
    assert_difference('NativeIssueHasAsana.count') do
      post :create, native_issue_has_asana: { asana_task_id: @native_issue_has_asana.asana_task_id, native_issue_id: @native_issue_has_asana.native_issue_id }
    end

    assert_redirected_to native_issue_has_asana_path(assigns(:native_issue_has_asana))
  end

  test "should show native_issue_has_asana" do
    get :show, id: @native_issue_has_asana
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @native_issue_has_asana
    assert_response :success
  end

  test "should update native_issue_has_asana" do
    patch :update, id: @native_issue_has_asana, native_issue_has_asana: { asana_task_id: @native_issue_has_asana.asana_task_id, native_issue_id: @native_issue_has_asana.native_issue_id }
    assert_redirected_to native_issue_has_asana_path(assigns(:native_issue_has_asana))
  end

  test "should destroy native_issue_has_asana" do
    assert_difference('NativeIssueHasAsana.count', -1) do
      delete :destroy, id: @native_issue_has_asana
    end

    assert_redirected_to native_issue_has_asanas_path
  end
end
