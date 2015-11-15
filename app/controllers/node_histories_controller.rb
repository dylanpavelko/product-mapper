class NodeHistoriesController < ApplicationController
  before_action :set_node_history, only: [:show, :edit, :update, :destroy]

  # GET /node_histories
  # GET /node_histories.json
  def index
    @node_histories = NodeHistory.all
  end

  # GET /node_histories/1
  # GET /node_histories/1.json
  def show
  end

  def show_node_history
    @node = Node.find(params[:id])
    @history_items = NodeHistory.where(:node_id => @node.id)
  end

  # GET /node_histories/new
  def new
    @node_history = NodeHistory.new
  end

  # GET /node_histories/1/edit
  def edit
  end

  # POST /node_histories
  # POST /node_histories.json
  def create
    @node_history = NodeHistory.new(node_history_params)

    respond_to do |format|
      if @node_history.save
        format.html { redirect_to @node_history, notice: 'Node history was successfully created.' }
        format.json { render :show, status: :created, location: @node_history }
      else
        format.html { render :new }
        format.json { render json: @node_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /node_histories/1
  # PATCH/PUT /node_histories/1.json
  def update
    respond_to do |format|
      if @node_history.update(node_history_params)
        format.html { redirect_to @node_history, notice: 'Node history was successfully updated.' }
        format.json { render :show, status: :ok, location: @node_history }
      else
        format.html { render :edit }
        format.json { render json: @node_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /node_histories/1
  # DELETE /node_histories/1.json
  def destroy
    @node_history.destroy
    respond_to do |format|
      format.html { redirect_to node_histories_url, notice: 'Node history was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_node_history
      @node_history = NodeHistory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def node_history_params
      params.require(:node_history).permit(:node_id, :user_id, :log, :type, :other_node_id, :other_reference_id)
    end
end
