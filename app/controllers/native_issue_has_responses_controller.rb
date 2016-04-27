class NativeIssueHasResponsesController < ApplicationController
  before_action :set_native_issue_has_response, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user
  before_filter :authorized_only

  # GET /native_issue_has_responses
  # GET /native_issue_has_responses.json
  def index
    @native_issue_has_responses = NativeIssueHasResponse.all
  end

  # GET /native_issue_has_responses/1
  # GET /native_issue_has_responses/1.json
  def show
  end

  # GET /native_issue_has_responses/new
  def new
    @native_issue_has_response = NativeIssueHasResponse.new
  end

  # GET /native_issue_has_responses/1/edit
  def edit
  end

  # POST /native_issue_has_responses
  # POST /native_issue_has_responses.json
  def create
    @native_issue_has_response = NativeIssueHasResponse.new(native_issue_has_response_params)

    respond_to do |format|
      if @native_issue_has_response.save
        format.html { redirect_to @native_issue_has_response, notice: 'Native issue has response was successfully created.' }
        format.json { render :show, status: :created, location: @native_issue_has_response }
      else
        format.html { render :new }
        format.json { render json: @native_issue_has_response.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /native_issue_has_responses/1
  # PATCH/PUT /native_issue_has_responses/1.json
  def update
    respond_to do |format|
      if @native_issue_has_response.update(native_issue_has_response_params)
        format.html { redirect_to @native_issue_has_response, notice: 'Native issue has response was successfully updated.' }
        format.json { render :show, status: :ok, location: @native_issue_has_response }
      else
        format.html { render :edit }
        format.json { render json: @native_issue_has_response.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /native_issue_has_responses/1
  # DELETE /native_issue_has_responses/1.json
  def destroy
    @native_issue_has_response.destroy
    respond_to do |format|
      format.html { redirect_to native_issue_has_responses_url, notice: 'Native issue has response was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_native_issue_has_response
      @native_issue_has_response = NativeIssueHasResponse.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def native_issue_has_response_params
      params.require(:native_issue_has_response).permit(:native_issue_id, :response_id)
    end
end
