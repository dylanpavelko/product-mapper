class JiraReposController < ApplicationController
  before_action :set_jira_repo, only: [:show, :edit, :update, :destroy]
            before_filter :authenticate_user
    before_filter :authorized_only

  # GET /jira_repos
  # GET /jira_repos.json
  def index
    @jira_repos = JiraRepo.all
  end

  # GET /jira_repos/1
  # GET /jira_repos/1.json
  def show
  end

  # GET /jira_repos/new
  def new
    @jira_repo = JiraRepo.new
  end

  # GET /jira_repos/1/edit
  def edit
  end

  # POST /jira_repos
  # POST /jira_repos.json
  def create
    @jira_repo = JiraRepo.new(jira_repo_params)

    respond_to do |format|
      if @jira_repo.save
        format.html { redirect_to @jira_repo, notice: 'Jira repo was successfully created.' }
        format.json { render :show, status: :created, location: @jira_repo }
      else
        format.html { render :new }
        format.json { render json: @jira_repo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jira_repos/1
  # PATCH/PUT /jira_repos/1.json
  def update
    respond_to do |format|
      if @jira_repo.update(jira_repo_params)
        format.html { redirect_to @jira_repo, notice: 'Jira repo was successfully updated.' }
        format.json { render :show, status: :ok, location: @jira_repo }
      else
        format.html { render :edit }
        format.json { render json: @jira_repo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jira_repos/1
  # DELETE /jira_repos/1.json
  def destroy
    @jira_repo.destroy
    respond_to do |format|
      format.html { redirect_to jira_repos_url, notice: 'Jira repo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_jira_repo
      @jira_repo = JiraRepo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def jira_repo_params
      params.require(:jira_repo).permit(:name, :url)
    end
end
