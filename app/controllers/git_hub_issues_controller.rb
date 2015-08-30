class GitHubIssuesController < ApplicationController
  before_action :set_git_hub_issue, only: [:show, :edit, :update, :destroy]
        before_filter :authenticate_user
    before_filter :authorized_only

  # GET /git_hub_issues
  # GET /git_hub_issues.json
  def index
    @git_hub_issues = GitHubIssue.all
  end

  # GET /git_hub_issues/1
  # GET /git_hub_issues/1.json
  def show
  end

  # GET /git_hub_issues/new
  def new
    @git_hub_issue = GitHubIssue.new
  end

  # GET /git_hub_issues/1/edit
  def edit
  end

  # POST /git_hub_issues
  # POST /git_hub_issues.json
  def create
    @git_hub_issue = GitHubIssue.new(git_hub_issue_params)

    respond_to do |format|
      if @git_hub_issue.save
        format.html { redirect_to @git_hub_issue, notice: 'Git hub issue was successfully created.' }
        format.json { render :show, status: :created, location: @git_hub_issue }
      else
        format.html { render :new }
        format.json { render json: @git_hub_issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /git_hub_issues/1
  # PATCH/PUT /git_hub_issues/1.json
  def update
    respond_to do |format|
      if @git_hub_issue.update(git_hub_issue_params)
        format.html { redirect_to @git_hub_issue, notice: 'Git hub issue was successfully updated.' }
        format.json { render :show, status: :ok, location: @git_hub_issue }
      else
        format.html { render :edit }
        format.json { render json: @git_hub_issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /git_hub_issues/1
  # DELETE /git_hub_issues/1.json
  def destroy
    @git_hub_issue.destroy
    respond_to do |format|
      format.html { redirect_to git_hub_issues_url, notice: 'Git hub issue was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_git_hub_issue
      @git_hub_issue = GitHubIssue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def git_hub_issue_params
      params.require(:git_hub_issue).permit(:gitHubID, :number, :title, :created, :updated, :closed, :body, :node_id, :repo_id)
    end
end
