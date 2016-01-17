class AsanaTasksController < ApplicationController
  before_action :set_asana_task, only: [:show, :edit, :update, :destroy]
            before_filter :authenticate_user
    before_filter :authorized_only

  # GET /asana_tasks
  # GET /asana_tasks.json
  def index
    @asana_tasks = AsanaTask.all
  end

  # GET /asana_tasks/1
  # GET /asana_tasks/1.json
  def show
    @native_issues = NativeIssueHasAsana.where(:asana_task_id => @asana_task.id)
  end

  # GET /asana_tasks/new
  def new
    @asana_task = AsanaTask.new
  end

  # GET /asana_tasks/1/edit
  def edit
  end

  # POST /asana_tasks
  # POST /asana_tasks.json
  def create
    @asana_task = AsanaTask.new(asana_task_params)

    respond_to do |format|
      if @asana_task.save
        format.html { redirect_to @asana_task, notice: 'Asana task was successfully created.' }
        format.json { render :show, status: :created, location: @asana_task }
      else
        format.html { render :new }
        format.json { render json: @asana_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /asana_tasks/1
  # PATCH/PUT /asana_tasks/1.json
  def update
    respond_to do |format|
      if @asana_task.update(asana_task_params)
        format.html { redirect_to @asana_task, notice: 'Asana task was successfully updated.' }
        format.json { render :show, status: :ok, location: @asana_task }
      else
        format.html { render :edit }
        format.json { render json: @asana_task.errors, status: :unprocessable_entity }
      end
    end
  end

  def get_from_url
     @response = Array.new()


     @asana = AsanaTask.new(:url => params[:url], :asana_workspace_id => params[:workspace_id])
     @response << true
     @response << [@asana.get_task_data_from_asana]
    render json: @response
  end

  # DELETE /asana_tasks/1
  # DELETE /asana_tasks/1.json
  def destroy
    @asana_task.destroy
    respond_to do |format|
      format.html { redirect_to asana_tasks_url, notice: 'Asana task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asana_task
      @asana_task = AsanaTask.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def asana_task_params
      params.require(:asana_task).permit(:name, :asana_id, :asana_workspace_id, :url)
    end
end
