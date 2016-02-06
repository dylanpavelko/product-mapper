require 'test_helper'

class NodeHasThemesControllerTest < ActionController::TestCase
  setup do
    @node_has_theme = node_has_themes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:node_has_themes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create node_has_theme" do
    assert_difference('NodeHasTheme.count') do
      post :create, node_has_theme: { node_id: @node_has_theme.node_id, theme_id: @node_has_theme.theme_id }
    end

    assert_redirected_to node_has_theme_path(assigns(:node_has_theme))
  end

  test "should show node_has_theme" do
    get :show, id: @node_has_theme
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @node_has_theme
    assert_response :success
  end

  test "should update node_has_theme" do
    patch :update, id: @node_has_theme, node_has_theme: { node_id: @node_has_theme.node_id, theme_id: @node_has_theme.theme_id }
    assert_redirected_to node_has_theme_path(assigns(:node_has_theme))
  end

  test "should destroy node_has_theme" do
    assert_difference('NodeHasTheme.count', -1) do
      delete :destroy, id: @node_has_theme
    end

    assert_redirected_to node_has_themes_path
  end
end
