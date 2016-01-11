require 'test_helper'

class AsanaAuthEndPointsControllerTest < ActionController::TestCase
  setup do
    @asana_auth_end_point = asana_auth_end_points(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:asana_auth_end_points)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create asana_auth_end_point" do
    assert_difference('AsanaAuthEndPoint.count') do
      post :create, asana_auth_end_point: { auth_code: @asana_auth_end_point.auth_code, bearer_token_id: @asana_auth_end_point.bearer_token_id, refresh_token: @asana_auth_end_point.refresh_token, token_date: @asana_auth_end_point.token_date, user_id: @asana_auth_end_point.user_id }
    end

    assert_redirected_to asana_auth_end_point_path(assigns(:asana_auth_end_point))
  end

  test "should show asana_auth_end_point" do
    get :show, id: @asana_auth_end_point
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @asana_auth_end_point
    assert_response :success
  end

  test "should update asana_auth_end_point" do
    patch :update, id: @asana_auth_end_point, asana_auth_end_point: { auth_code: @asana_auth_end_point.auth_code, bearer_token_id: @asana_auth_end_point.bearer_token_id, refresh_token: @asana_auth_end_point.refresh_token, token_date: @asana_auth_end_point.token_date, user_id: @asana_auth_end_point.user_id }
    assert_redirected_to asana_auth_end_point_path(assigns(:asana_auth_end_point))
  end

  test "should destroy asana_auth_end_point" do
    assert_difference('AsanaAuthEndPoint.count', -1) do
      delete :destroy, id: @asana_auth_end_point
    end

    assert_redirected_to asana_auth_end_points_path
  end
end
