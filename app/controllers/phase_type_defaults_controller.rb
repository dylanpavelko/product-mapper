class PhaseTypeDefaultsController < ApplicationController
  before_action :set_phase_type_default, only: [:show, :edit, :update, :destroy]

  # GET /phase_type_defaults
  # GET /phase_type_defaults.json
  def index
    @phase_type_defaults = PhaseTypeDefault.all
  end

  # GET /phase_type_defaults/1
  # GET /phase_type_defaults/1.json
  def show
  end

  # GET /phase_type_defaults/new
  def new
    @phase_type_default = PhaseTypeDefault.new
  end

  # GET /phase_type_defaults/1/edit
  def edit
  end

  # POST /phase_type_defaults
  # POST /phase_type_defaults.json
  def create
    @phase_type_default = PhaseTypeDefault.new(phase_type_default_params)

    respond_to do |format|
      if @phase_type_default.save
        format.html { redirect_to @phase_type_default, notice: 'Phase type default was successfully created.' }
        format.json { render :show, status: :created, location: @phase_type_default }
      else
        format.html { render :new }
        format.json { render json: @phase_type_default.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /phase_type_defaults/1
  # PATCH/PUT /phase_type_defaults/1.json
  def update
    respond_to do |format|
      if @phase_type_default.update(phase_type_default_params)
        format.html { redirect_to @phase_type_default, notice: 'Phase type default was successfully updated.' }
        format.json { render :show, status: :ok, location: @phase_type_default }
      else
        format.html { render :edit }
        format.json { render json: @phase_type_default.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phase_type_defaults/1
  # DELETE /phase_type_defaults/1.json
  def destroy
    @phase_type_default.destroy
    respond_to do |format|
      format.html { redirect_to phase_type_defaults_url, notice: 'Phase type default was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_phase_type_default
      @phase_type_default = PhaseTypeDefault.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def phase_type_default_params
      params[:phase_type_default]
    end
end
