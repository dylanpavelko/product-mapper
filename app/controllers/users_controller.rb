class UsersController < ApplicationController
  before_filter :save_login_state, :only => [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user, :only => [:show, :edit, :index]


  def new
    @user = User.new 
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
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit(:username, :email, :firstName, :lastName, :password, :role_id, :password_confirmation)
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
