class UsersController < ApplicationController
  before_filter :save_login_state, :only => [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy, :change_password]
  before_filter :authenticate_user, :only => [:show, :edit, :index, :add, :change_password]
  before_filter :authorized_only, only: [:index, :show, :update, :destroy, :add, :change_password]


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
    @filters = session[:filters]
      if @filters == nil
        @filters = Array.new
      end
    @roles = UserHasRoleForNode.where(:user_id => @user.id)

    @has_node_roles = @roles
    @my_feature_roles = Array.new
    @my_non_feature_roles = Array.new
    @has_node_roles.each do |has_node_role|
      if has_node_role.node != nil and has_node_role.node.nodeType.feature
        @my_feature_roles << has_node_role
      else 
        @my_non_feature_roles << has_node_role
      end
    end

    @my_feature_roles = @my_feature_roles.sort_by {|has_node| [has_node.node.belongs_to_product, has_node.node.name]}
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        if @current_user.power_admin
          format.html { redirect_to @user, notice: 'User was successfully updated.' }
        else
          format.html { redirect_to sessions_home_path, notice: 'User was successfully updated.' }
        end
        format.json { render :show, status: :ok, location: @user }
      else
        if !@current_user.power_admin
          format.html { render :change_password }
        else
          format.html { render :edit }
        end
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

  def change_photo
    @profile_image = ProfileImage.new
    @user = User.find(params[:id])
  end

  def set_photo
    @user = params[:profile_image][:user_id]
    @existing = ProfileImage.where(:user_id => @user)
    @existing.each do |exists|
      exists.delete
    end
    @profile_image = ProfileImage.create( image_params )
    redirect_to user_path(@user)
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def image_params
    params.require(:profile_image).permit(:image, :user_id)
  end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
end
