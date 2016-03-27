class InboxItemsController < ApplicationController
  before_action :set_inbox_item, only: [:show, :edit, :update, :destroy]
    before_filter :authenticate_user
  before_filter :authorized_only

  # GET /inbox_items
  # GET /inbox_items.json
  def index
    @inbox_items = InboxItem.all
  end

  # GET /inbox_items/1
  # GET /inbox_items/1.json
  def show
  end

  # GET /inbox_items/new
  def new
    @inbox_item = InboxItem.new
  end

  # GET /inbox_items/1/edit
  def edit
  end

  # POST /inbox_items
  # POST /inbox_items.json
  def create
    @inbox_item = InboxItem.new(inbox_item_params)

    respond_to do |format|
      if @inbox_item.save
        format.html { redirect_to @inbox_item, notice: 'Inbox item was successfully created.' }
        format.json { render :show, status: :created, location: @inbox_item }
      else
        format.html { render :new }
        format.json { render json: @inbox_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inbox_items/1
  # PATCH/PUT /inbox_items/1.json
  def update
    respond_to do |format|
      if @inbox_item.update(inbox_item_params)
        format.html { redirect_to @inbox_item, notice: 'Inbox item was successfully updated.' }
        format.json { render :show, status: :ok, location: @inbox_item }
      else
        format.html { render :edit }
        format.json { render json: @inbox_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inbox_items/1
  # DELETE /inbox_items/1.json
  def destroy
    @inbox_item.destroy
    respond_to do |format|
      format.html { redirect_to inbox_items_url, notice: 'Inbox item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def mark_inbox_item_as_read
    @inbox_item = InboxItem.find(params[:inbox_item_id])
    @inbox_item.update(:read => params[:read])
    render :json => @inbox_item 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inbox_item
      @inbox_item = InboxItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inbox_item_params
      params.require(:inbox_item).permit(:user_id, :activity_id, :read)
    end
end
