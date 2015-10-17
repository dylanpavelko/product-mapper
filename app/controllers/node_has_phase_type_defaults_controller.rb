class NodeHasPhaseTypeDefaultsController < ApplicationController
  before_action :set_node_has_phase_type_default, only: [:show, :edit, :update, :destroy]
      before_filter :authenticate_user
    before_filter :authorized_only

  # GET /node_has_phase_type_defaults
  # GET /node_has_phase_type_defaults.json
  def index
    @node_has_phase_type_defaults = NodeHasPhaseTypeDefault.all
  end

  # GET /node_has_phase_type_defaults/1
  # GET /node_has_phase_type_defaults/1.json
  def show
  end

  # GET /node_has_phase_type_defaults/new
  def new
    @node_has_phase_type_default = NodeHasPhaseTypeDefault.new
    @nodeTypes = NodeType.all
    @phaseTypes = PhaseType.all
  end

  # GET /node_has_phase_type_defaults/1/edit
  def edit
  end

  # POST /node_has_phase_type_defaults
  # POST /node_has_phase_type_defaults.json
  def create
    @node_has_phase_type_default = NodeHasPhaseTypeDefault.new(node_has_phase_type_default_params)

    respond_to do |format|
      if @node_has_phase_type_default.save
        format.html { redirect_to @node_has_phase_type_default, notice: 'Node has phase type default was successfully created.' }
        format.json { render :show, status: :created, location: @node_has_phase_type_default }
      else
        format.html { render :new }
        format.json { render json: @node_has_phase_type_default.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /node_has_phase_type_defaults/1
  # PATCH/PUT /node_has_phase_type_defaults/1.json
  def update
    respond_to do |format|
      if @node_has_phase_type_default.update(node_has_phase_type_default_params)
        format.html { redirect_to @node_has_phase_type_default, notice: 'Node has phase type default was successfully updated.' }
        format.json { render :show, status: :ok, location: @node_has_phase_type_default }
      else
        format.html { render :edit }
        format.json { render json: @node_has_phase_type_default.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /node_has_phase_type_defaults/1
  # DELETE /node_has_phase_type_defaults/1.json
  def destroy
    @node_has_phase_type_default.destroy
    respond_to do |format|
      format.html { redirect_to node_has_phase_type_defaults_url, notice: 'Node has phase type default was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_node_has_phase_type_default
      @node_has_phase_type_default = NodeHasPhaseTypeDefault.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def node_has_phase_type_default_params
      params.require(:node_has_phase_type_default).permit(:node_id, :phase_type_default_id)
    end
end
