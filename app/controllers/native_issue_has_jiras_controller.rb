class NativeIssueHasJirasController < ApplicationController
  before_action :set_native_issue_has_jira, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user
  before_filter :authorized_only
  
  # GET /native_issue_has_jiras
  # GET /native_issue_has_jiras.json
  def index
    @native_issue_has_jiras = NativeIssueHasJira.all
  end

  # GET /native_issue_has_jiras/1
  # GET /native_issue_has_jiras/1.json
  def show
  end

  # GET /native_issue_has_jiras/new
  def new
    @native_issue_has_jira = NativeIssueHasJira.new
  end

  # GET /native_issue_has_jiras/1/edit
  def edit
  end

  # POST /native_issue_has_jiras
  # POST /native_issue_has_jiras.json
  def create
    @native_issue_has_jira = NativeIssueHasJira.new(native_issue_has_jira_params)

    respond_to do |format|
      if @native_issue_has_jira.save
        format.html { redirect_to @native_issue_has_jira, notice: 'Native issue has jira was successfully created.' }
        format.json { render :show, status: :created, location: @native_issue_has_jira }
      else
        format.html { render :new }
        format.json { render json: @native_issue_has_jira.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /native_issue_has_jiras/1
  # PATCH/PUT /native_issue_has_jiras/1.json
  def update
    respond_to do |format|
      if @native_issue_has_jira.update(native_issue_has_jira_params)
        format.html { redirect_to @native_issue_has_jira, notice: 'Native issue has jira was successfully updated.' }
        format.json { render :show, status: :ok, location: @native_issue_has_jira }
      else
        format.html { render :edit }
        format.json { render json: @native_issue_has_jira.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /native_issue_has_jiras/1
  # DELETE /native_issue_has_jiras/1.json
  def destroy
    @native_issue_has_jira.destroy
    respond_to do |format|
      format.html { redirect_to native_issue_has_jiras_url, notice: 'Native issue has jira was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_native_issue_has_jira
      @native_issue_has_jira = NativeIssueHasJira.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def native_issue_has_jira_params
      params.require(:native_issue_has_jira).permit(:jira_id, :native_issue_id)
    end
end
