class JiraIssuesController < ApplicationController
  before_action :set_jira_issue, only: [:show, :edit, :update, :destroy]
            before_filter :authenticate_user
    before_filter :authorized_only

  # GET /jira_issues
  # GET /jira_issues.json
  def index
    @jira_issues = JiraIssue.all
  end

  # GET /jira_issues/1
  # GET /jira_issues/1.json
  def show
  end

  # GET /jira_issues/new
  def new
    @jira_issue = JiraIssue.new
  end

  # GET /jira_issues/1/edit
  def edit
  end

  # POST /jira_issues
  # POST /jira_issues.json
  def create
    @jira_issue = JiraIssue.new(jira_issue_params)

    respond_to do |format|
      if @jira_issue.save
        format.html { redirect_to @jira_issue, notice: 'Jira issue was successfully created.' }
        format.json { render :show, status: :created, location: @jira_issue }
      else
        format.html { render :new }
        format.json { render json: @jira_issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jira_issues/1
  # PATCH/PUT /jira_issues/1.json
  def update
    respond_to do |format|
      if @jira_issue.update(jira_issue_params)
        format.html { redirect_to @jira_issue, notice: 'Jira issue was successfully updated.' }
        format.json { render :show, status: :ok, location: @jira_issue }
      else
        format.html { render :edit }
        format.json { render json: @jira_issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jira_issues/1
  # DELETE /jira_issues/1.json
  def destroy
    @jira_issue.destroy
    respond_to do |format|
      format.html { redirect_to jira_issues_url, notice: 'Jira issue was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_jira_issue
      @jira_issue = JiraIssue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def jira_issue_params
      params.require(:jira_issue).permit(:jira_repo_id, :key, :summary)
    end
end
