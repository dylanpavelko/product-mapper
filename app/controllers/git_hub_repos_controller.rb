class GitHubReposController < ApplicationController
  before_action :set_git_hub_repo, only: [:show, :edit, :update, :destroy]
      before_filter :authenticate_user
    before_filter :authorized_only

  # GET /git_hub_repos
  # GET /git_hub_repos.json
  def index
    @git_hub_repos = GitHubRepo.all
  end

  # GET /git_hub_repos/1
  # GET /git_hub_repos/1.json
  def show
  end

  # GET /git_hub_repos/new
  def new
    @git_hub_repo = GitHubRepo.new
    randomString = (0...8).map { (65 + rand(26)).chr }.join
    redirect_to("https://github.com/login/oauth/authorize?client_id=9d811885f4f2c8354197&redirect_uri=https://product-mapper.dylanpavelko.com/githubrepo/new&state="+randomString)
  end

  # GET /git_hub_repos/1/edit
  def edit
  end

  # POST /git_hub_repos
  # POST /git_hub_repos.json
  def create
    @git_hub_repo = GitHubRepo.new(git_hub_repo_params)

    respond_to do |format|
      if @git_hub_repo.save
        format.html { redirect_to @git_hub_repo, notice: 'Git hub repo was successfully created.' }
        format.json { render :show, status: :created, location: @git_hub_repo }
      else
        format.html { render :new }
        format.json { render json: @git_hub_repo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /git_hub_repos/1
  # PATCH/PUT /git_hub_repos/1.json
  def update
    respond_to do |format|
      if @git_hub_repo.update(git_hub_repo_params)
        format.html { redirect_to @git_hub_repo, notice: 'Git hub repo was successfully updated.' }
        format.json { render :show, status: :ok, location: @git_hub_repo }
      else
        format.html { render :edit }
        format.json { render json: @git_hub_repo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /git_hub_repos/1
  # DELETE /git_hub_repos/1.json
  def destroy
    @git_hub_repo.destroy
    respond_to do |format|
      format.html { redirect_to git_hub_repos_url, notice: 'Git hub repo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_git_hub_repo
      @git_hub_repo = GitHubRepo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def git_hub_repo_params
      params.require(:git_hub_repo).permit(:repo, :node_id, :user_id)
    end
end
