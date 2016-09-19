class GoogleSheetHasMappingsController < ApplicationController
  before_action :set_google_sheet_has_mapping, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user
  before_filter :authorized_only  

  # GET /google_sheet_has_mappings
  # GET /google_sheet_has_mappings.json
  def index
    if params[:sheet_id] != nil
      @google_sheet_has_mappings = GoogleSheetHasMapping.where(:google_sheet_id => params[:sheet_id])
    else
      @google_sheet_has_mappings = GoogleSheetHasMapping.all
    end
  end

  # GET /google_sheet_has_mappings/1
  # GET /google_sheet_has_mappings/1.json
  def show
  end

  # GET /google_sheet_has_mappings/new
  def new
    @google_sheet_has_mapping = GoogleSheetHasMapping.new
  end

  # GET /google_sheet_has_mappings/1/edit
  def edit
  end

  # POST /google_sheet_has_mappings
  # POST /google_sheet_has_mappings.json
  def create
    @google_sheet_has_mapping = GoogleSheetHasMapping.new(google_sheet_has_mapping_params)

    respond_to do |format|
      if @google_sheet_has_mapping.save
        format.html { redirect_to @google_sheet_has_mapping, notice: 'Google sheet has mapping was successfully created.' }
        format.json { render :show, status: :created, location: @google_sheet_has_mapping }
      else
        format.html { render :new }
        format.json { render json: @google_sheet_has_mapping.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /google_sheet_has_mappings/1
  # PATCH/PUT /google_sheet_has_mappings/1.json
  def update
    respond_to do |format|
      if @google_sheet_has_mapping.update(google_sheet_has_mapping_params)
        format.html { redirect_to @google_sheet_has_mapping, notice: 'Google sheet has mapping was successfully updated.' }
        format.json { render :show, status: :ok, location: @google_sheet_has_mapping }
      else
        format.html { render :edit }
        format.json { render json: @google_sheet_has_mapping.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /google_sheet_has_mappings/1
  # DELETE /google_sheet_has_mappings/1.json
  def destroy
    @google_sheet_has_mapping.destroy
    respond_to do |format|
      format.html { redirect_to google_sheet_has_mappings_url, notice: 'Google sheet has mapping was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_google_sheet_has_mapping
      @google_sheet_has_mapping = GoogleSheetHasMapping.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def google_sheet_has_mapping_params
      params.require(:google_sheet_has_mapping).permit(:column_name, :column_number, :data_type, :google_sheet_id, :customer_id)
    end
end
