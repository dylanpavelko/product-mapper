class NativeIssuesController < ApplicationController
  before_action :set_native_issue, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user
  before_filter :authorized_only

  # GET /native_issues
  # GET /native_issues.json
  def index
    @native_issues = NativeIssue.all
  end

  # GET /native_issues/1
  # GET /native_issues/1.json
  def show
    @has_asanas = NativeIssueHasAsana.where(:native_issue_id => @native_issue.id)
  end

  # GET /native_issues/new
  def new
    @native_issue = NativeIssue.new
    @node = Node.find(params[:format])

    #this will need to be improved
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

    #you should be looking for the asana, and if you can't find it, then creating one here instead of always just creating one
    @asana_task = AsanaTask.new(:url => params[:native_issue][:asana_url], :asana_workspace_id => params[:native_issue][:asana_workspace_id])

    respond_to do |format|
      if @native_issue.save
        @asana_task.save
        @native_issue_has_asana = NativeIssueHasAsana.new(:asana_task_id => @asana_task.id, :native_issue_id => @native_issue.id)
        @native_issue_has_asana.save
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_native_issue
      @native_issue = NativeIssue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def native_issue_params
      params.require(:native_issue).permit(:summary, :description, :enhancement, :issue_with_id, 
        :resolved_with_id, :close_without_resolution, :asana_id, :asana_url, :asana_workspace_id)
    end
end
