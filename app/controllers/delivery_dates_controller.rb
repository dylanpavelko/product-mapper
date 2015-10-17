class DeliveryDatesController < ApplicationController
  before_action :set_delivery_date, only: [:show, :edit, :update, :destroy]
          before_filter :authenticate_user
    before_filter :authorized_only

  # GET /delivery_dates
  # GET /delivery_dates.json
  def index
    @delivery_dates = DeliveryDate.all
  end

  # GET /delivery_dates/1
  # GET /delivery_dates/1.json
  def show
  end

  # GET /delivery_dates/new
  def new
    @delivery_date = DeliveryDate.new
    @node = Node.find(params[:format])
  end

  # GET /delivery_dates/1/edit
  def edit
    @node = @delivery_date.node
  end

  # POST /delivery_dates
  # POST /delivery_dates.json
  def create
    @delivery_date = DeliveryDate.new(delivery_date_params)

    respond_to do |format|
      if @delivery_date.save
        format.html { redirect_to @delivery_date.node, notice: 'Delivery date was successfully created.' }
        format.json { render :show, status: :created, location: @delivery_date }
      else
        format.html { render :new }
        format.json { render json: @delivery_date.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /delivery_dates/1
  # PATCH/PUT /delivery_dates/1.json
  def update
    respond_to do |format|
      if @delivery_date.update(delivery_date_params)
        format.html { redirect_to @delivery_date.node, notice: 'Delivery date was successfully updated.' }
        format.json { render :show, status: :ok, location: @delivery_date }
      else
        format.html { render :edit }
        format.json { render json: @delivery_date.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /delivery_dates/1
  # DELETE /delivery_dates/1.json
  def destroy
    @delivery_date.destroy
    respond_to do |format|
      format.html { redirect_to delivery_dates_url, notice: 'Delivery date was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_delivery_date
      @delivery_date = DeliveryDate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def delivery_date_params
      params.require(:delivery_date).permit(:node_id, :target_type, :envrionment_id, :milestone_id, :date)
    end
end
