class SessionsController < ApplicationController
  before_filter :authenticate_user, :only => [:home, :profile, :setting]
  before_filter :save_login_state, :only => [:login, :login_attempt]

  MILESTONE_FILTER = 1

	def login
    	#Login Form
  	end


	def login_attempt
	  authorized_user = User.authenticate(params[:username_or_email],params[:login_password])
	  if authorized_user
	    session[:user_id] = authorized_user.id
	    flash[:notice] = "Wow Welcome again, you logged in as #{authorized_user.username}"
	    if authorized_user.password_reset == 1
	    	redirect_to(change_password_path(authorized_user))
	    else
		    redirect_to(:action => 'home')
		end
	  else
	    flash[:notice] = "Invalid Username or Password"
	    flash[:color]= "invalid"
	    render "login"	
	  end
	end

	def logout
	  session[:user_id] = nil
	  session[:filters] = nil
	  redirect_to :action => 'login'
	end

	def home
		@has_node_roles = UserHasRoleForNode.where(:user_id => @current_user.id)
		@my_feature_roles = Array.new
		@has_node_roles.each do |has_node_role|
			if has_node_role.node != nil and has_node_role.node.nodeType.feature
				@my_feature_roles << has_node_role
			end
		end
		@my_feature_roles = @my_feature_roles.sort_by {|has_node| [has_node.node.belongs_to_product, has_node.node.name]}
	end

	def profile
	end

	def setting
	end

	def add_filter
		newFilters = Array.new
		newFilters << [MILESTONE_FILTER, params[:filter_data]]
		session[:filters] = newFilters
		render json: newFilters
	end

	def remove_filter
		newFilters = Array.new
		#newFilters << [MILESTONE_FILTER, params[:filter_data]]
		session[:filters] = newFilters
		render json: newFilters
	end
end
