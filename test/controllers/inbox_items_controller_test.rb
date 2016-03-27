require 'test_helper'

class InboxItemsControllerTest < ActionController::TestCase
  setup do
    @inbox_item = inbox_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:inbox_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create inbox_item" do
    assert_difference('InboxItem.count') do
      post :create, inbox_item: { activity_id: @inbox_item.activity_id, read: @inbox_item.read, user_id: @inbox_item.user_id }
    end

    assert_redirected_to inbox_item_path(assigns(:inbox_item))
  end

  test "should show inbox_item" do
    get :show, id: @inbox_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @inbox_item
    assert_response :success
  end

  test "should update inbox_item" do
    patch :update, id: @inbox_item, inbox_item: { activity_id: @inbox_item.activity_id, read: @inbox_item.read, user_id: @inbox_item.user_id }
    assert_redirected_to inbox_item_path(assigns(:inbox_item))
  end

  test "should destroy inbox_item" do
    assert_difference('InboxItem.count', -1) do
      delete :destroy, id: @inbox_item
    end

    assert_redirected_to inbox_items_path
  end
end
