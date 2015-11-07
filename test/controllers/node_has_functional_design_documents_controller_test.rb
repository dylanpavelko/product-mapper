require 'test_helper'

class NodeHasFunctionalDesignDocumentsControllerTest < ActionController::TestCase
  setup do
    @node_has_functional_design_document = node_has_functional_design_documents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:node_has_functional_design_documents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create node_has_functional_design_document" do
    assert_difference('NodeHasFunctionalDesignDocument.count') do
      post :create, node_has_functional_design_document: { FDD_id: @node_has_functional_design_document.FDD_id, node_id: @node_has_functional_design_document.node_id }
    end

    assert_redirected_to node_has_functional_design_document_path(assigns(:node_has_functional_design_document))
  end

  test "should show node_has_functional_design_document" do
    get :show, id: @node_has_functional_design_document
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @node_has_functional_design_document
    assert_response :success
  end

  test "should update node_has_functional_design_document" do
    patch :update, id: @node_has_functional_design_document, node_has_functional_design_document: { FDD_id: @node_has_functional_design_document.FDD_id, node_id: @node_has_functional_design_document.node_id }
    assert_redirected_to node_has_functional_design_document_path(assigns(:node_has_functional_design_document))
  end

  test "should destroy node_has_functional_design_document" do
    assert_difference('NodeHasFunctionalDesignDocument.count', -1) do
      delete :destroy, id: @node_has_functional_design_document
    end

    assert_redirected_to node_has_functional_design_documents_path
  end
end
