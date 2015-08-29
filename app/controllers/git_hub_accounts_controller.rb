class GitHubAccountsController < ApplicationController
  before_action :set_git_hub_account, only: [:show, :edit, :update, :destroy]
      before_filter :authenticate_user
    before_filter :authorized_only

  # GET /git_hub_accounts
  # GET /git_hub_accounts.json
  def index
    @git_hub_accounts = GitHubAccount.all
  end

  # GET /git_hub_accounts/1
  # GET /git_hub_accounts/1.json
  def show
  end

  # GET /git_hub_accounts/new
  def new
    @git_hub_account = GitHubAccount.new
  end

  # GET /git_hub_accounts/1/edit
  def edit
  end

  # POST /git_hub_accounts
  # POST /git_hub_accounts.json
  def create
    @git_hub_account = GitHubAccount.new(git_hub_account_params)

    respond_to do |format|
      if @git_hub_account.save
        format.html { redirect_to @git_hub_account, notice: 'Git hub account was successfully created.' }
        format.json { render :show, status: :created, location: @git_hub_account }
      else
        format.html { render :new }
        format.json { render json: @git_hub_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /git_hub_accounts/1
  # PATCH/PUT /git_hub_accounts/1.json
  def update
    respond_to do |format|
      if @git_hub_account.update(git_hub_account_params)
        format.html { redirect_to @git_hub_account, notice: 'Git hub account was successfully updated.' }
        format.json { render :show, status: :ok, location: @git_hub_account }
      else
        format.html { render :edit }
        format.json { render json: @git_hub_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /git_hub_accounts/1
  # DELETE /git_hub_accounts/1.json
  def destroy
    @git_hub_account.destroy
    respond_to do |format|
      format.html { redirect_to git_hub_accounts_url, notice: 'Git hub account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_git_hub_account
      @git_hub_account = GitHubAccount.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def git_hub_account_params
      params.require(:git_hub_account).permit(:oauth, :user_id)
    end
end
