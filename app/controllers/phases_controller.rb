class PhasesController < ApplicationController
  before_action :set_phase, only: [:show, :edit, :update, :destroy]
    before_filter :authenticate_user
    before_filter :authorized_only

  # GET /phases
  # GET /phases.json
  def index
    @phases = Phase.all
  end

  # GET /phases/1
  # GET /phases/1.json
  def show
  end

  # GET /phases/new
  def new
    @phase = Phase.new
    @node = Node.find(params[:format])
  end

  # GET /phases/1/edit
  def edit
  end

  # POST /phases
  # POST /phases.json
  def create
    @phase = Phase.new(phase_params)

    respond_to do |format|
      if @phase.save
        format.html { redirect_to @phase, notice: 'Phase was successfully created.' }
        format.json { render :show, status: :created, location: @phase }
      else
        format.html { render :new }
        format.json { render json: @phase.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /phases/1
  # PATCH/PUT /phases/1.json
  def update
    respond_to do |format|
      if @phase.update(phase_params)
        format.html { redirect_to @phase, notice: 'Phase was successfully updated.' }
        format.json { render :show, status: :ok, location: @phase }
      else
        format.html { render :edit }
        format.json { render json: @phase.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phases/1
  # DELETE /phases/1.json
  def destroy
    @phase.destroy
    respond_to do |format|
      format.html { redirect_to phases_url, notice: 'Phase was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # def set_phase_status
  #     @phase = Phase.find(params[:id])
  #     @phase.update(:status => params[:phase_status])
  #     render :nothing => true
  # end

  def set_progress_status
      @phase = Phase.find(params[:id])
      @progress_status = params[:phase_progress_status]
      @phase.update(:progress_status => @progress_status)
      #check to see if you should set the phase_status too?
      if @progress_status == "1"
        @phase.update_attribute(:status, true)
      else
        @phase.update_attribute(:status,false)
      end
      add_activity_to_subscribers_inbox(@phase.create_activity :update, owner: @current_user, parameters: {progress_status: @phase.progress_status, node_id: @phase.node.id})
      #sync up the node status
      @phase.node.reset_feature_spec_node_status
      @phase.node.save

      render :nothing => true
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_phase
      @phase = Phase.find(params[:id])
    end



    # Never trust parameters from the scary internet, only allow the white list through.
    def phase_params
      params.require(:phase).permit(:phaseType_id, :status, :node_id, :dependencies_id, :progress_status)
    end
end
