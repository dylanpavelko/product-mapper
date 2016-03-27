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
	    @inbox_items = InboxItem.where(:user_id => @current_user, :read => false)
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
	    if !(params[:include_specs])
	    	@nodes = Node.select { |x| x.nodeType.specification != true }
	    else
	    	@nodes = Node.all
	    end

	    @matched_items = Array.new
	    @nodes.each do |node|
	      if node.matches(@search_string) #and node.user_has_access(@current_user)
	        @matched_items << node
	      end
	    end
	    @matched_items.each do |item|
	      @response << [0, item.nodeType.name + ': ' + item.name, item.id]
	    end

	   	#find functional design documents
	    @FDDs = FunctionalDesignDocument.all

	    @matched_items = Array.new
	    @FDDs.each do |fdd|
	      if fdd.matches(@search_string) #and node.user_has_access(@current_user)
	        @matched_items << fdd
	      end
	    end
	    @matched_items.each do |item|
	      @response << [1, 'Functional Design Document: ' + item.name, item.id]
	    end


        @response << [@response.count.to_s + ' item(s) found: for ' + @search_string]
    	render json: @response
    end

    public
    def add_activity_to_subscribers_inbox(activity)
puts activity.inspect    	
    	#get the the closest relevant node for the activity
    	if activity.trackable_type == "NativeIssue"
    		@relevant_node = activity.trackable.issue_with
    	elsif activity.trackable_type == "Response"
	    	if activity.parameters[:type] == "issue"
				@issue = NativeIssue.find(activity.parameters[:native_issue_id]) 
				@relevant_node = Node.find(@issue.issue_with_id)
			elsif activity.parameters[:type] == "question"
				@question = Question.find(activity.parameters[:question_id]) 
				@relevant_node = @question.node
			end
		elsif activity.trackable_type == "Question"
			@relevant_node = Node.find(activity.trackable.node_id)
		elsif activity.trackable_type == "DeliveryDate"
			if activity.trackable
				@relevant_node = Node.find(activity.trackable.node_id)
			else 
				@relevant_node = Node.find(activity.parameters[:node])
			end
		elsif activity.trackable_type == "Phase"
			@relevant_node = Node.find(activity.parameters[:node_id])
		elsif activity.trackable_type == "Node"
			@relevant_node = Node.find(activity.trackable.id)
    	end

    	#get all the relevant nodes
    	@relevant_nodes = Array.new
    	@relevant_nodes << @relevant_node
    	@relevant_node.parents.each do |parent|
    		@relevant_nodes << parent
    	end

    	@user_roles = Array.new
    	#get all assigned roles at that node and every ancestor node
    	@relevant_nodes.each do |node|
    		@user_roles += UserHasRoleForNode.where(:node_id => node.id)
    	end

    	@subscribers = Array.new
    	#get a unique list of users with a role that subscribes to this activity, excluding the current_user
    	@user_roles.each do |user_role|
    		if user_role.subscribes_to(activity) and !@subscribers.include? user_role.user and user_role.user != @current_user
    			@subscribers << user_role.user
    		end
    	end

    	if activity.trackable_type == "Response"
    		if activity.parameters[:type] == "issue"
    			@owner = User.find(@issue.added_by_id)
    		elsif activity.parameters[:type] == "question"
    			@owner = User.find(@question.asked_by_user_id)
    		end
    		if @owner != nil and !@subscribers.include? @owner and @owner != @current_user.id
    			@subscribers << @owner
    		end
    	end

    	#add the activity as an inbox item for each unique user
    	@subscribers.each do |subscriber|
    		@inbox_item = InboxItem.create(:user_id => subscriber.id, :activity_id => activity.id, :read => false)
    		@inbox_item.save
    	end
    end
end
