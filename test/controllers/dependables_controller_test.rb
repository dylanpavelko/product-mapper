require 'test_helper'

class DependablesControllerTest < ActionController::TestCase
  setup do
    @dependable = dependables(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dependables)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dependable" do
    assert_difference('Dependable.count') do
      post :create, dependable: {  }
    end

    assert_redirected_to dependable_path(assigns(:dependable))
  end

  test "should show dependable" do
    get :show, id: @dependable
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dependable
    assert_response :success
  end

  test "should update dependable" do
    patch :update, id: @dependable, dependable: {  }
    assert_redirected_to dependable_path(assigns(:dependable))
  end

  test "should destroy dependable" do
    assert_difference('Dependable.count', -1) do
      delete :destroy, id: @dependable
    end

    assert_redirected_to dependables_path
  end
end
