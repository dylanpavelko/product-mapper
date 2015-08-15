class PhaseTypesController < ApplicationController
  before_action :set_phase_type, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user
  before_filter :authorized_only

  # GET /phase_types
  # GET /phase_types.json
  def index
    @phase_types = PhaseType.all
  end

  # GET /phase_types/1
  # GET /phase_types/1.json
  def show
  end

  # GET /phase_types/new
  def new
    @phase_type = PhaseType.new
  end

  # GET /phase_types/1/edit
  def edit
  end

  # POST /phase_types
  # POST /phase_types.json
  def create
    @phase_type = PhaseType.new(phase_type_params)

    respond_to do |format|
      if @phase_type.save
        format.html { redirect_to @phase_type, notice: 'Phase type was successfully created.' }
        format.json { render :show, status: :created, location: @phase_type }
      else
        format.html { render :new }
        format.json { render json: @phase_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /phase_types/1
  # PATCH/PUT /phase_types/1.json
  def update
    respond_to do |format|
      if @phase_type.update(phase_type_params)
        format.html { redirect_to @phase_type, notice: 'Phase type was successfully updated.' }
        format.json { render :show, status: :ok, location: @phase_type }
      else
        format.html { render :edit }
        format.json { render json: @phase_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phase_types/1
  # DELETE /phase_types/1.json
  def destroy
    @phase_type.destroy
    respond_to do |format|
      format.html { redirect_to phase_types_url, notice: 'Phase type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_phase_type
      @phase_type = PhaseType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def phase_type_params
      params.require(:phase_type).permit(:name)
    end
end
