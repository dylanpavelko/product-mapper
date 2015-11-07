require 'test_helper'

class FunctionalDesignDocumentsControllerTest < ActionController::TestCase
  setup do
    @functional_design_document = functional_design_documents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:functional_design_documents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create functional_design_document" do
    assert_difference('FunctionalDesignDocument.count') do
      post :create, functional_design_document: { name: @functional_design_document.name, url: @functional_design_document.url }
    end

    assert_redirected_to functional_design_document_path(assigns(:functional_design_document))
  end

  test "should show functional_design_document" do
    get :show, id: @functional_design_document
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @functional_design_document
    assert_response :success
  end

  test "should update functional_design_document" do
    patch :update, id: @functional_design_document, functional_design_document: { name: @functional_design_document.name, url: @functional_design_document.url }
    assert_redirected_to functional_design_document_path(assigns(:functional_design_document))
  end

  test "should destroy functional_design_document" do
    assert_difference('FunctionalDesignDocument.count', -1) do
      delete :destroy, id: @functional_design_document
    end

    assert_redirected_to functional_design_documents_path
  end
end
