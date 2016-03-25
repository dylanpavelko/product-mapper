class ActivitiesController < ApplicationController
  before_filter :authenticate_user
  before_filter :authorized_only

  def index
  	@activities = PublicActivity::Activity.order("created_at desc")
  end
end
