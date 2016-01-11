require 'test_helper'

class AsanaTasksControllerTest < ActionController::TestCase
  setup do
    @asana_task = asana_tasks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:asana_tasks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create asana_task" do
    assert_difference('AsanaTask.count') do
      post :create, asana_task: { asana_id: @asana_task.asana_id, asana_workspace_id: @asana_task.asana_workspace_id, name: @asana_task.name }
    end

    assert_redirected_to asana_task_path(assigns(:asana_task))
  end

  test "should show asana_task" do
    get :show, id: @asana_task
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @asana_task
    assert_response :success
  end

  test "should update asana_task" do
    patch :update, id: @asana_task, asana_task: { asana_id: @asana_task.asana_id, asana_workspace_id: @asana_task.asana_workspace_id, name: @asana_task.name }
    assert_redirected_to asana_task_path(assigns(:asana_task))
  end

  test "should destroy asana_task" do
    assert_difference('AsanaTask.count', -1) do
      delete :destroy, id: @asana_task
    end

    assert_redirected_to asana_tasks_path
  end
end
