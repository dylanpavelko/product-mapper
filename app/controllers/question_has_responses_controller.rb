class QuestionHasResponsesController < ApplicationController
  before_action :set_question_has_response, only: [:show, :edit, :update, :destroy]
        before_filter :authenticate_user
    before_filter :authorized_only

  # GET /question_has_responses
  # GET /question_has_responses.json
  def index
    @question_has_responses = QuestionHasResponse.all
  end

  # GET /question_has_responses/1
  # GET /question_has_responses/1.json
  def show
  end

  # GET /question_has_responses/new
  def new
    @question_has_response = QuestionHasResponse.new
  end

  # GET /question_has_responses/1/edit
  def edit
  end

  # POST /question_has_responses
  # POST /question_has_responses.json
  def create
    @question_has_response = QuestionHasResponse.new(question_has_response_params)

    respond_to do |format|
      if @question_has_response.save
        format.html { redirect_to @question_has_response, notice: 'Question has response was successfully created.' }
        format.json { render :show, status: :created, location: @question_has_response }
      else
        format.html { render :new }
        format.json { render json: @question_has_response.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /question_has_responses/1
  # PATCH/PUT /question_has_responses/1.json
  def update
    respond_to do |format|
      if @question_has_response.update(question_has_response_params)
        format.html { redirect_to @question_has_response, notice: 'Question has response was successfully updated.' }
        format.json { render :show, status: :ok, location: @question_has_response }
      else
        format.html { render :edit }
        format.json { render json: @question_has_response.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /question_has_responses/1
  # DELETE /question_has_responses/1.json
  def destroy
    @question_has_response.destroy
    respond_to do |format|
      format.html { redirect_to question_has_responses_url, notice: 'Question has response was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question_has_response
      @question_has_response = QuestionHasResponse.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_has_response_params
      params.require(:question_has_response).permit(:question_id, :response_id, :answers)
    end
end
