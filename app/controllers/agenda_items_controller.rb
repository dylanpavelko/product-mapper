class AgendaItemsController < ApplicationController
  before_filter :authenticate_user
  before_filter :authorized_only
  
  before_action :set_agenda_item, only: [:show, :edit, :update, :destroy]

  # GET /agenda_items
  # GET /agenda_items.json
  def index
    @agenda_items = AgendaItem.all
  end

  # GET /agenda_items/1
  # GET /agenda_items/1.json
  def show
    @action_items = ActionItem.where(:action_from_agenda_item => @agenda_item.id)
  end

  # GET /agenda_items/new
  def new
    @agenda_item = AgendaItem.new
    @meeting = Meeting.find(params[:meeting_id])
  end

  # GET /agenda_items/1/edit
  def edit
  end

  # POST /agenda_items
  # POST /agenda_items.json
  def create
    @agenda_item = AgendaItem.new(agenda_item_params)

    respond_to do |format|
      if @agenda_item.save
        format.html { redirect_to @agenda_item, notice: 'Agenda item was successfully created.' }
        format.json { render :show, status: :created, location: @agenda_item }
      else
        format.html { render :new }
        format.json { render json: @agenda_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /agenda_items/1
  # PATCH/PUT /agenda_items/1.json
  def update
    respond_to do |format|
      if @agenda_item.update(agenda_item_params)
        format.html { redirect_to @agenda_item, notice: 'Agenda item was successfully updated.' }
        format.json { render :show, status: :ok, location: @agenda_item }
      else
        format.html { render :edit }
        format.json { render json: @agenda_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /agenda_items/1
  # DELETE /agenda_items/1.json
  def destroy
    @agenda_item.destroy
    respond_to do |format|
      format.html { redirect_to agenda_items_url, notice: 'Agenda item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_agenda_item
      @agenda_item = AgendaItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def agenda_item_params
      params.require(:agenda_item).permit(:name, :meeting_id, :order)
    end
end
