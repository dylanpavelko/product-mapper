class AsanaWorkspacesController < ApplicationController
  before_action :set_asana_workspace, only: [:show, :edit, :update, :destroy]
        before_filter :authenticate_user
    before_filter :authorized_only

  # GET /asana_workspaces
  # GET /asana_workspaces.json
  def index
    @asana_workspaces = AsanaWorkspace.all
  end

  # GET /asana_workspaces/1
  # GET /asana_workspaces/1.json
  def show
  end

  # GET /asana_workspaces/new
  def new
    @asana_workspace = AsanaWorkspace.new
  end

  # GET /asana_workspaces/1/edit
  def edit
  end

  # POST /asana_workspaces
  # POST /asana_workspaces.json
  def create
    @asana_workspace = AsanaWorkspace.new(asana_workspace_params)

    respond_to do |format|
      if @asana_workspace.save
        format.html { redirect_to @asana_workspace, notice: 'Asana workspace was successfully created.' }
        format.json { render :show, status: :created, location: @asana_workspace }
      else
        format.html { render :new }
        format.json { render json: @asana_workspace.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /asana_workspaces/1
  # PATCH/PUT /asana_workspaces/1.json
  def update
    respond_to do |format|
      if @asana_workspace.update(asana_workspace_params)
        format.html { redirect_to @asana_workspace, notice: 'Asana workspace was successfully updated.' }
        format.json { render :show, status: :ok, location: @asana_workspace }
      else
        format.html { render :edit }
        format.json { render json: @asana_workspace.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /asana_workspaces/1
  # DELETE /asana_workspaces/1.json
  def destroy
    @asana_workspace.destroy
    respond_to do |format|
      format.html { redirect_to asana_workspaces_url, notice: 'Asana workspace was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asana_workspace
      @asana_workspace = AsanaWorkspace.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def asana_workspace_params
      params.require(:asana_workspace).permit(:workspace, :node_id, :added_by_id)
    end
end
