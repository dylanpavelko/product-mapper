require 'test_helper'

class DeliveryDatesControllerTest < ActionController::TestCase
  setup do
    @delivery_date = delivery_dates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:delivery_dates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create delivery_date" do
    assert_difference('DeliveryDate.count') do
      post :create, delivery_date: { date: @delivery_date.date, envrionment_id: @delivery_date.envrionment_id, milestone_id: @delivery_date.milestone_id, node_id: @delivery_date.node_id, target_type: @delivery_date.target_type }
    end

    assert_redirected_to delivery_date_path(assigns(:delivery_date))
  end

  test "should show delivery_date" do
    get :show, id: @delivery_date
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @delivery_date
    assert_response :success
  end

  test "should update delivery_date" do
    patch :update, id: @delivery_date, delivery_date: { date: @delivery_date.date, envrionment_id: @delivery_date.envrionment_id, milestone_id: @delivery_date.milestone_id, node_id: @delivery_date.node_id, target_type: @delivery_date.target_type }
    assert_redirected_to delivery_date_path(assigns(:delivery_date))
  end

  test "should destroy delivery_date" do
    assert_difference('DeliveryDate.count', -1) do
      delete :destroy, id: @delivery_date
    end

    assert_redirected_to delivery_dates_path
  end
end
