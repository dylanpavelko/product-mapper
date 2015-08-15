class DependablesController < ApplicationController
  before_action :set_dependable, only: [:show, :edit, :update, :destroy]

  # GET /dependables
  # GET /dependables.json
  def index
    @dependables = Dependable.all
  end

  # GET /dependables/1
  # GET /dependables/1.json
  def show
  end

  # GET /dependables/new
  def new
    @dependable = Dependable.new
    @dependentPhase = Phase.find(params[:phase_id])
  end

  # GET /dependables/1/edit
  def edit
  end

  # POST /dependables
  # POST /dependables.json
  def create
    @dependable = Dependable.new(dependable_params)
    respond_to do |format|
      if @dependable.save
        @dependentPhase.depdendencies = @dependable
        format.html { redirect_to @dependable, notice: 'Dependable was successfully created.' }
        format.json { render :show, status: :created, location: @dependable }
      else
        format.html { render :new }
        format.json { render json: @dependable.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dependables/1
  # PATCH/PUT /dependables/1.json
  def update
    respond_to do |format|
      if @dependable.update(dependable_params)
        format.html { redirect_to @dependable, notice: 'Dependable was successfully updated.' }
        format.json { render :show, status: :ok, location: @dependable }
      else
        format.html { render :edit }
        format.json { render json: @dependable.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dependables/1
  # DELETE /dependables/1.json
  def destroy
    @dependable.destroy
    respond_to do |format|
      format.html { redirect_to dependables_url, notice: 'Dependable was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dependable
      @dependable = Dependable.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dependable_params
      params[:dependable].permit(:node_id, :phase_id, :dependentPhase_id)
    end

    def add_depency_to_dependable(dependable)
      @dependentPHase = Phase.find(dependable.id)
      @phase.dependencies << dependable
      @phase.save
    end
end
