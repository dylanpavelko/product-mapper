class GitHubReposController < ApplicationController
  before_action :set_git_hub_repo, only: [:show, :edit, :update, :destroy]
      before_filter :authenticate_user
    before_filter :authorized_only

    require 'net/http'
    require 'cgi'
    require "open-uri"
    require 'rubygems'
    require 'json'

  # GET /git_hub_repos
  # GET /git_hub_repos.json
  def index
    @git_hub_repos = GitHubRepo.all
  end

  # GET /git_hub_repos/1
  # GET /git_hub_repos/1.json
  def show
    @data = URI.parse("https://api.github.com/repos/dylanpavelko/"+@git_hub_repo.repo+"/issues").read
    @structuredResponse = JSON.parse(@data)
    @repoID = @git_hub_repo.id
    @structuredResponse.each do |issue|
      #if issue doesn't already exist
      if GitHubIssue.where(:gitHubID => issue['id']).count == 0
        #create issue for repo and top level node
        @ghIssue = GitHubIssue.new(
          :gitHubID => issue['id'], 
          :number => issue['number'],
          :title => issue['title'],
          :created => issue['created_at'],
          :updated => issue['updated_at'],
          :closed => issue['closed_at'],
          :body => issue['body'],
          :repo_id => @repoID,
          :node => @git_hub_repo.node)
        @ghIssue.save
      end
    end

  end

  # GET /git_hub_repos/new
  def new
    @git_hub_repo = GitHubRepo.new
    @redirect_path = "https://product-mapper.dylanpavelko.com/"
    #If product mapper has not authorized GitHub Account access
    if GitHubAccount.where(:user_id => @current_user).count == 0 
      randomString = (0...8).map { (65 + rand(26)).chr }.join
      @gitHubAccount = GitHubAccount.new(:user => @current_user, :state => randomString)
      @gitHubAccount.save
      redirect_to("https://github.com/login/oauth/authorize?client_id=9d811885f4f2c8354197" +
                  "&redirect_uri=" + @redirect_path + "git_hub_repos/new"+
                  "&state="+randomString)
    elsif(params[:code] != nil && GitHubAccount.where(:user => @current_user).first.oauth == nil)
      @gitHubAccount = GitHubAccount.where(:user => @current_user).first
      params["client_id"] = "9d811885f4f2c8354197"
      params["client_secret"] = '854943e5ecebec4ade117eb1235de56410ec7257'
      params["code"] = params[:code]
      params["redirect_uri"] = @redirect_path + "git_hub_repos/new"
      params["state"] = @gitHubAccount.state
      @response = Net::HTTP.post_form(URI.parse("https://github.com/login/oauth/access_token"), params)
      @structuredResponse = CGI::parse(@response.body)
      puts token = @structuredResponse['access_token'][0]
      @gitHubAccount.update(:oauth => token)
    end


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
      params.require(:git_hub_repo).permit(:repo, :node_id, :user_id, :state, :code)
    end
end
