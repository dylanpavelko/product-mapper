class ResponsesController < ApplicationController
  before_action :set_response, only: [:show, :edit, :update, :destroy]
        before_filter :authenticate_user
    before_filter :authorized_only

  # GET /responses
  # GET /responses.json
  def index
    @responses = Response.all
  end

  # GET /responses/1
  # GET /responses/1.json
  def show
  end

  # GET /responses/new
  def new
    @response = Response.new
  end

  # GET /responses/1/edit
  def edit
  end

  # POST /responses
  # POST /responses.json
  def create
    @response = Response.new(response_params)

    respond_to do |format|
      if @response.save
        format.html { redirect_to @response, notice: 'Response was successfully created.' }
        format.json { render :show, status: :created, location: @response }
      else
        format.html { render :new }
        format.json { render json: @response.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /responses/1
  # PATCH/PUT /responses/1.json
  def update
    respond_to do |format|
      if @response.update(response_params)
        format.html { redirect_to @response, notice: 'Response was successfully updated.' }
        format.json { render :show, status: :ok, location: @response }
      else
        format.html { render :edit }
        format.json { render json: @response.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /responses/1
  # DELETE /responses/1.json
  def destroy
    @response.destroy
    respond_to do |format|
      format.html { redirect_to responses_url, notice: 'Response was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_response_to_question
    @response = Response.new(:content => params[:response], :user => User.find(params[:user_id]))
    @response.save

    @question_has_response = QuestionHasResponse.new(:question_id => params[:question_id],
     :response_id => @response.id, :answers => params[:answered])
    @question_has_response.save
    if params[:answered] == "true"
      @question = Question.find(params[:question_id])
      @question.update(:resolved_id => 1)
      @question.save
    end

    render :json => @response 
  end

  def add_response_to_native_issue
    @response = Response.new(:content => params[:response], :user => User.find(params[:user_id]))
    @response.save

    @question_has_response = NativeIssueHasResponse.new(:native_issue_id => params[:native_issue_id],
     :response_id => @response.id)
    @question_has_response.save

    render :json => @response 
  end
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_response
      @response = Response.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def response_params
      params.require(:response).permit(:content, :user_id)
    end

    def question_response_params
      params.permit(:question_id,:response,:user_id,:answered)
end
