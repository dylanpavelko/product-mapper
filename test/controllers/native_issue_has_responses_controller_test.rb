require 'test_helper'

class NativeIssueHasResponsesControllerTest < ActionController::TestCase
  setup do
    @native_issue_has_response = native_issue_has_responses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:native_issue_has_responses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create native_issue_has_response" do
    assert_difference('NativeIssueHasResponse.count') do
      post :create, native_issue_has_response: { native_issue_id: @native_issue_has_response.native_issue_id, response_id: @native_issue_has_response.response_id }
    end

    assert_redirected_to native_issue_has_response_path(assigns(:native_issue_has_response))
  end

  test "should show native_issue_has_response" do
    get :show, id: @native_issue_has_response
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @native_issue_has_response
    assert_response :success
  end

  test "should update native_issue_has_response" do
    patch :update, id: @native_issue_has_response, native_issue_has_response: { native_issue_id: @native_issue_has_response.native_issue_id, response_id: @native_issue_has_response.response_id }
    assert_redirected_to native_issue_has_response_path(assigns(:native_issue_has_response))
  end

  test "should destroy native_issue_has_response" do
    assert_difference('NativeIssueHasResponse.count', -1) do
      delete :destroy, id: @native_issue_has_response
    end

    assert_redirected_to native_issue_has_responses_path
  end
end
