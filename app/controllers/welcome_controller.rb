class WelcomeController < ApplicationController
  def index
  	if session[:user_id] != nil
	    redirect_to(sessions_home_path)
	end
	@home = true;
  end
end
