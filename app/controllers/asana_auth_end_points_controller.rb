class AsanaAuthEndPointsController < ApplicationController
  before_action :set_asana_auth_end_point, only: [:show, :edit, :update, :destroy]
        before_filter :authenticate_user
    before_filter :authorized_only

  # GET /asana_auth_end_points
  # GET /asana_auth_end_points.json
  def index
    @asana_auth_end_points = AsanaAuthEndPoint.all
  end

  # GET /asana_auth_end_points/1
  # GET /asana_auth_end_points/1.json
  def show
  end

  # GET /asana_auth_end_points/new
  def new
    @asana_auth_end_point = AsanaAuthEndPoint.new
  end

  # GET /asana_auth_end_points/1/edit
  def edit
  end

  # POST /asana_auth_end_points
  # POST /asana_auth_end_points.json
  def create
    @asana_auth_end_point = AsanaAuthEndPoint.new(asana_auth_end_point_params)

    respond_to do |format|
      if @asana_auth_end_point.save
        format.html { redirect_to @asana_auth_end_point, notice: 'Asana auth end point was successfully created.' }
        format.json { render :show, status: :created, location: @asana_auth_end_point }
      else
        format.html { render :new }
        format.json { render json: @asana_auth_end_point.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /asana_auth_end_points/1
  # PATCH/PUT /asana_auth_end_points/1.json
  def update
    respond_to do |format|
      if @asana_auth_end_point.update(asana_auth_end_point_params)
        format.html { redirect_to @asana_auth_end_point, notice: 'Asana auth end point was successfully updated.' }
        format.json { render :show, status: :ok, location: @asana_auth_end_point }
      else
        format.html { render :edit }
        format.json { render json: @asana_auth_end_point.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /asana_auth_end_points/1
  # DELETE /asana_auth_end_points/1.json
  def destroy
    @asana_auth_end_point.destroy
    respond_to do |format|
      format.html { redirect_to asana_auth_end_points_url, notice: 'Asana auth end point was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asana_auth_end_point
      @asana_auth_end_point = AsanaAuthEndPoint.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def asana_auth_end_point_params
      params.require(:asana_auth_end_point).permit(:user_id, :auth_code, :bearer_token, :token_date, :refresh_token)
    end
end
