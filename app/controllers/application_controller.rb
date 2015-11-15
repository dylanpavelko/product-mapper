class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  protected 
	def authenticate_user
	  if session[:user_id]
	     # set current user object to @current_user object variable
	    @current_user = User.find session[:user_id] 
	    @favorite_nodes = UserHasFavoriteNode.where(:user_id => @current_user.id)
	    return true	
	  else
	    redirect_to(:controller => 'sessions', :action => 'login')
	    return false
	  end
	end
	
	def save_login_state
	  if session[:user_id]
#	    redirect_to(:controller => 'sessions', :action => 'home')
	    return false
	  else
	    return true
	  end
	end

	protected 
	def authorized_only
	  if session[:user_id]
	     # set current user object to @current_user object variable
	    @current_user = User.find session[:user_id] 
	    if @current_user.power_admin
	       	return true
	    elsif @current_user.can_view_nodes
	    	return true
	    else
	    	redirect_to(sessions_profile_path)
	    	return false
	    end
	    return true	
	  else
	    redirect_to(:controller => 'sessions', :action => 'login')
	    return false
	  end
	end

	public
	def header_search
	    @search_string = params[:search_string];
	    @response = Array.new


	    #find matching nodes
	    @nodes = Node.select { |x| x.nodeType.specification != true }
	    @matched_items = Array.new
	    @nodes.each do |node|
	      if node.matches(@search_string) #and node.user_has_access(@current_user)
	        @matched_items << node
	      end
	    end
	    @matched_items.each do |item|
	      @response << [0, item.nodeType.name + ': ' + item.name, item.id]
	    end

        @response << [@response.count.to_s + ' item(s) found: for ' + @search_string]
    	render json: @response

    end
end
