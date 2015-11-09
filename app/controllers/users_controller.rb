class UsersController < ApplicationController
  before_filter :save_login_state, :only => [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user, :only => [:show, :edit, :index, :add]
  before_filter :authorized_only, only: [:index, :show, :update, :destroy, :add]


  def new
    if session[:user_id]
      authenticate_user
    end
    @user = User.new 
  end

  def add_user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @users = User.all
      if (@users.count == 1)
      	@user.update_attribute(:power_admin, true)
      end
      flash[:notice] = "You signed up successfully"
      flash[:color]= "valid"
    else
      flash[:notice] = "Form is invalid"
      flash[:color]= "invalid"
    end
    if session[:user_id]
      redirect_to users_path
    else
      redirect_to root_path
    end
  end

  def edit
  end

  def show
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def user_params
    params.require(:user).permit(:username, :email, :first_name, :last_name, :password, 
      :role_id, :password_confirmation, :password_reset)
  end

  def index
    @users = User.all
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
end
