class NativeIssuesController < ApplicationController
  before_action :set_native_issue, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user
  before_filter :authorized_only

  # GET /native_issues
  # GET /native_issues.json
  def index
    @native_issues = NativeIssue.where(nil) # creates an anonymous scope

    filtering_params(params).each do |key, value|
      @native_issues = @native_issues.public_send(key, value) if value.present?
    end

    @opened_by = User.find(params[:added_by]) if params[:added_by]
    @after = Date.strptime(params[:after], '%Y-%m-%d') if params[:after]
    @before = Date.strptime(params[:before], '%Y-%m-%d') if params[:before]

    if(params[:node] != nil)
      @node = Node.find(params[:node])
      @node_issues = @node.getAllIssues

      @native_issues = @native_issues & @node_issues
    end

    if params[:issue_status] != nil
      @any_status = @native_issues
      @native_issues = Array.new
      if params[:issue_status] == "open" 
        #anything not closed w/o resolution or resolved with is not done
        @any_status.each do |issue|
          if (issue.resolved_with == nil and !issue.close_without_resolution) or (issue.resolved_with != nil and !issue.resolved_with.status)
            @native_issues << issue
          end
        end
      elsif params[:issue_status] == "unaddressed" 
        #anything without a resolution and not resolved w/o resolution
        @any_status.each do |issue|
          if issue.resolved_with == nil and !issue.close_without_resolution
            @native_issues << issue
          end
        end
      elsif params[:issue_status] == "resolved"
        #anything that is closed w/o resolution or resolved with is done
        @any_status.each do |issue|
          if issue.close_without_resolution or (issue.resolved_with != nil and issue.resolved_with.status)
            @native_issues << issue
          end
        end
      end

    end
  end

  # A list of the param names that can be used for filtering the NativeIssue list
  def filtering_params(params)
    params.slice(:added_by, :after, :before)
  end

  # GET /native_issues/1
  # GET /native_issues/1.json
  def show
    @has_asanas = NativeIssueHasAsana.where(:native_issue_id => @native_issue.id)
    @has_jiras = NativeIssueHasJira.where(:native_issue_id => @native_issue.id)
    @has_responses = NativeIssueHasResponse.where(:native_issue_id => @native_issue)
    @has_impacts = NativeIssueHasImpact.where(:native_issue_id => @native_issue)
  end

  # GET /native_issues/new
  def new
    @native_issue = NativeIssue.new
    @node = Node.find(params[:format])

    #this will need to be improved also in create method
    @workspace = AsanaWorkspace.all.first
  end

  # GET /native_issues/1/edit
  def edit
    @node = @native_issue.issue_with

    #this will need to be improved
    @workspace = AsanaWorkspace.all.first
  end

  # POST /native_issues
  # POST /native_issues.json
  def create
    @native_issue = NativeIssue.new(native_issue_params)
    @node = Node.find(@native_issue.issue_with_id)
    #this will need to be improved
    @workspace = AsanaWorkspace.all.first

    if params[:native_issue][:asana_id] != ""
      #you should be looking for the asana, and if you can't find it, then creating one here instead of always just creating one
      @existing_asana = AsanaTask.where(:asana_id => params[:native_issue][:asana_id]) + AsanaTask.where(:url => params[:native_issue][:asana_url])
      if @existing_asana != nil and @existing_asana.count != 0
        @asana_task = @existing_asana.first
      else
        @asana_task = AsanaTask.new(:url => params[:native_issue][:asana_url], 
                                    :asana_workspace_id => params[:native_issue][:asana_workspace_id], 
                                    :asana_id => params[:native_issue][:asana_id],
                                    :name => params[:native_issue][:asana_name])
        @asana_task.save
      end
    end
    respond_to do |format|
      if @native_issue.save
        add_activity_to_subscribers_inbox(@native_issue.create_activity :create, owner: @current_user)
        if params[:native_issue][:asana_id] != "" or params[:native_issue][:asana_id] == nil
          @native_issue_has_asana = NativeIssueHasAsana.new(:asana_task_id => @asana_task.id, :native_issue_id => @native_issue.id)
          @native_issue_has_asana.save
        end
        format.html { redirect_to @native_issue, notice: 'Native issue was successfully created.' }
        format.json { render :show, status: :created, location: @native_issue }
      else
        format.html { render :new }
        format.json { render json: @native_issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /native_issues/1
  # PATCH/PUT /native_issues/1.json
  def update
    respond_to do |format|
      if @native_issue.update(native_issue_params)
        add_activity_to_subscribers_inbox(@native_issue.create_activity :update, owner: @current_user)
        format.html { redirect_to @native_issue, notice: 'Native issue was successfully updated.' }
        format.json { render :show, status: :ok, location: @native_issue }
      else
        format.html { render :edit }
        format.json { render json: @native_issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /native_issues/1
  # DELETE /native_issues/1.json
  def destroy
    @native_issue.destroy
    respond_to do |format|
      format.html { redirect_to native_issues_url, notice: 'Native issue was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_jira_to_native_issue
    @native_issue = NativeIssue.find(params[:native_issue_id])

    @jira_repo = JiraRepo.all.first
    @existing_jira = JiraIssue.where(:key => params[:jira_key], :jira_repo_id => @jira_repo.id)
    if @existing_jira.count > 0
      @jira = @existing_jira.first
    else
      @jira = JiraIssue.new(:jira_repo_id => @jira_repo.id , :key => params[:jira_key], :summary => params[:jira_summary])
      @jira.save
    end

    @native_issue_has_jira_issue = NativeIssueHasJira.new(:native_issue_id => @native_issue.id, :jira_id => @jira.id)
    @native_issue_has_jira_issue.save

    render :json => @native_issue 
  end

  def add_customer_impact_to_native_issue
    @native_issue = NativeIssue.find(params[:native_issue_id])
    @customer_ids = params[:customers]
    @impact = params[:impact]

    @customer_ids.each do |customer_id|
      @customer_impact = NativeIssueHasImpact.new(:customer_id => customer_id, :native_issue_id => @native_issue.id, :impact => @impact)
      @customer_impact.save()
    end

    render :json => @native_issue 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_native_issue
      @native_issue = NativeIssue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def native_issue_params
      params.require(:native_issue).permit(:summary, :description, :enhancement, :issue_with_id, 
        :resolved_with_id, :close_without_resolution, :asana_id, :asana_url, :asana_workspace_id, :asana_name, :added_by_id)
    end
end
