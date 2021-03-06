class CapacitiesController < ApplicationController
  before_action :set_capacity, only: [:show, :edit, :update, :destroy]
    before_filter :authenticate_user
    before_filter :authorized_only

  # GET /capacities
  # GET /capacities.json
  def index
    @capacities = Capacity.all
  end

  # GET /capacities/1
  # GET /capacities/1.json
  def show
  end

  # GET /capacities/new
  def new
    @capacity = Capacity.new
  end

  # GET /capacities/1/edit
  def edit
  end

  # POST /capacities
  # POST /capacities.json
  def create
    @capacity = Capacity.new(capacity_params)

    respond_to do |format|
      if @capacity.save
        format.html { redirect_to @capacity, notice: 'Capacity was successfully created.' }
        format.json { render :show, status: :created, location: @capacity }
      else
        format.html { render :new }
        format.json { render json: @capacity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /capacities/1
  # PATCH/PUT /capacities/1.json
  def update
    respond_to do |format|
      if @capacity.update(capacity_params)
        format.html { redirect_to @capacity, notice: 'Capacity was successfully updated.' }
        format.json { render :show, status: :ok, location: @capacity }
      else
        format.html { render :edit }
        format.json { render json: @capacity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /capacities/1
  # DELETE /capacities/1.json
  def destroy
    @capacity.destroy
    respond_to do |format|
      format.html { redirect_to capacities_url, notice: 'Capacity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_capacity
      @capacity = Capacity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def capacity_params
      params.require(:capacity).permit(:amount, :team_id, :milestone_id)
    end
end
