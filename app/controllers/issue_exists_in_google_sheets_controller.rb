class IssueExistsInGoogleSheetsController < ApplicationController
  before_action :set_issue_exists_in_google_sheet, only: [:show, :edit, :update, :destroy]
      before_filter :authenticate_user
  before_filter :authorized_only

  # GET /issue_exists_in_google_sheets
  # GET /issue_exists_in_google_sheets.json
  def index
    @issue_exists_in_google_sheets = IssueExistsInGoogleSheet.all
  end

  # GET /issue_exists_in_google_sheets/1
  # GET /issue_exists_in_google_sheets/1.json
  def show
  end

  # GET /issue_exists_in_google_sheets/new
  def new
    @issue_exists_in_google_sheet = IssueExistsInGoogleSheet.new
  end

  # GET /issue_exists_in_google_sheets/1/edit
  def edit
  end

  # POST /issue_exists_in_google_sheets
  # POST /issue_exists_in_google_sheets.json
  def create
    @issue_exists_in_google_sheet = IssueExistsInGoogleSheet.new(issue_exists_in_google_sheet_params)

    respond_to do |format|
      if @issue_exists_in_google_sheet.save
        format.html { redirect_to @issue_exists_in_google_sheet, notice: 'Issue exists in google sheet was successfully created.' }
        format.json { render :show, status: :created, location: @issue_exists_in_google_sheet }
      else
        format.html { render :new }
        format.json { render json: @issue_exists_in_google_sheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /issue_exists_in_google_sheets/1
  # PATCH/PUT /issue_exists_in_google_sheets/1.json
  def update
    respond_to do |format|
      if @issue_exists_in_google_sheet.update(issue_exists_in_google_sheet_params)
        format.html { redirect_to @issue_exists_in_google_sheet, notice: 'Issue exists in google sheet was successfully updated.' }
        format.json { render :show, status: :ok, location: @issue_exists_in_google_sheet }
      else
        format.html { render :edit }
        format.json { render json: @issue_exists_in_google_sheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /issue_exists_in_google_sheets/1
  # DELETE /issue_exists_in_google_sheets/1.json
  def destroy
    @issue_exists_in_google_sheet.destroy
    respond_to do |format|
      format.html { redirect_to issue_exists_in_google_sheets_url, notice: 'Issue exists in google sheet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_issue_exists_in_google_sheet
      @issue_exists_in_google_sheet = IssueExistsInGoogleSheet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def issue_exists_in_google_sheet_params
      params.require(:issue_exists_in_google_sheet).permit(:native_issue_id, :google_sheet_id, :external_id)
    end
end
