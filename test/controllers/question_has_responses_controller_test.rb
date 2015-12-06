require 'test_helper'

class QuestionHasResponsesControllerTest < ActionController::TestCase
  setup do
    @question_has_response = question_has_responses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:question_has_responses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create question_has_response" do
    assert_difference('QuestionHasResponse.count') do
      post :create, question_has_response: { answers: @question_has_response.answers, question_id: @question_has_response.question_id, response_id: @question_has_response.response_id }
    end

    assert_redirected_to question_has_response_path(assigns(:question_has_response))
  end

  test "should show question_has_response" do
    get :show, id: @question_has_response
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @question_has_response
    assert_response :success
  end

  test "should update question_has_response" do
    patch :update, id: @question_has_response, question_has_response: { answers: @question_has_response.answers, question_id: @question_has_response.question_id, response_id: @question_has_response.response_id }
    assert_redirected_to question_has_response_path(assigns(:question_has_response))
  end

  test "should destroy question_has_response" do
    assert_difference('QuestionHasResponse.count', -1) do
      delete :destroy, id: @question_has_response
    end

    assert_redirected_to question_has_responses_path
  end
end
