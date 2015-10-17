class PhaseTypeDefaultHasPhaseTypesController < ApplicationController
  before_action :set_phase_type_default_has_phase_type, only: [:show, :edit, :update, :destroy]

  # GET /phase_type_default_has_phyase_types
  # GET /phase_type_default_has_phyase_types.json
  def index
    @phase_type_default_has_phase_types = PhaseTypeDefaultHasPhaseType.all
  end

  # GET /phase_type_default_has_phyase_types/1
  # GET /phase_type_default_has_phyase_types/1.json
  def show
  end

  # GET /phase_type_default_has_phyase_types/new
  def new
    @phase_type_default_has_phase_type = PhaseTypeDefaultHasPhaseType.new
  end

  # GET /phase_type_default_has_phyase_types/1/edit
  def edit
  end

  # POST /phase_type_default_has_phyase_types
  # POST /phase_type_default_has_phyase_types.json
  def create
    @phase_type_default_has_phase_type = PhaseTypeDefaultHasPhaseType.new(phase_type_default_has_phyase_type_params)

    respond_to do |format|
      if @phase_type_default_has_phyase_type.save
        format.html { redirect_to @phase_type_default_has_phyase_type, notice: 'Phase type default has phyase type was successfully created.' }
        format.json { render :show, status: :created, location: @phase_type_default_has_phyase_type }
      else
        format.html { render :new }
        format.json { render json: @phase_type_default_has_phyase_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /phase_type_default_has_phyase_types/1
  # PATCH/PUT /phase_type_default_has_phyase_types/1.json
  def update
    respond_to do |format|
      if @phase_type_default_has_phyase_type.update(phase_type_default_has_phyase_type_params)
        format.html { redirect_to @phase_type_default_has_phyase_type, notice: 'Phase type default has phyase type was successfully updated.' }
        format.json { render :show, status: :ok, location: @phase_type_default_has_phyase_type }
      else
        format.html { render :edit }
        format.json { render json: @phase_type_default_has_phyase_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phase_type_default_has_phyase_types/1
  # DELETE /phase_type_default_has_phyase_types/1.json
  def destroy
    @phase_type_default_has_phyase_type.destroy
    respond_to do |format|
      format.html { redirect_to phase_type_default_has_phyase_types_url, notice: 'Phase type default has phyase type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_phase_type_default_has_phyase_type
      @phase_type_default_has_phyase_type = PhaseTypeDefaultHasPhaseType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def phase_type_default_has_phyase_type_params
      params.require(:phase_type_default_has_phyase_type).permit(:phase_type_default_id, :phase_type_id)
    end
end
