class GoogleSheetsController < ApplicationController
  before_action :set_google_sheet, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user
  before_filter :authorized_only

  # GET /google_sheets
  # GET /google_sheets.json
  def index
    @google_sheets = GoogleSheet.all
  end

  # GET /google_sheets/1
  # GET /google_sheets/1.json
  def show
    @mappings = GoogleSheetHasMapping.where(:google_sheet_id => @google_sheet.id)
    @imported_issues = IssueExistsInGoogleSheet.where(:google_sheet_id => @google_sheet.id)
  end

  # GET /google_sheets/new
  def new
    @google_sheet = GoogleSheet.new
  end

  # GET /google_sheets/1/edit
  def edit
  end

  # POST /google_sheets
  # POST /google_sheets.json
  def create
    @google_sheet = GoogleSheet.new(google_sheet_params)

    respond_to do |format|
      if @google_sheet.save
        format.html { redirect_to @google_sheet, notice: 'Google sheet was successfully created.' }
        format.json { render :show, status: :created, location: @google_sheet }
      else
        format.html { render :new }
        format.json { render json: @google_sheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /google_sheets/1
  # PATCH/PUT /google_sheets/1.json
  def update
    respond_to do |format|
      if @google_sheet.update(google_sheet_params)
        format.html { redirect_to @google_sheet, notice: 'Google sheet was successfully updated.' }
        format.json { render :show, status: :ok, location: @google_sheet }
      else
        format.html { render :edit }
        format.json { render json: @google_sheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /google_sheets/1
  # DELETE /google_sheets/1.json
  def destroy
    @google_sheet.destroy
    respond_to do |format|
      format.html { redirect_to google_sheets_url, notice: 'Google sheet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import_new_native_issue_from_google_sheet   
    @native_issue = NativeIssue.new(:summary => params[:native_issue_summary],
                                    :description => params[:native_issue_description],
                                    :enhancement => params[:native_issue_enhancement],
                                    :added_by_id => params[:native_issue_opened_by],
                                    :issue_with_id => params[:native_issue_with_node_id])
    @node = Node.find(@native_issue.issue_with_id)
    if @native_issue.save
      #add issue_exists_in_google_sheet
      @issue_in_google = IssueExistsInGoogleSheet.new(:native_issue_id => @native_issue.id, 
                                                      :google_sheet_id => params[:google_sheet_id], 
                                                      :external_id => params[:google_sheet_row_id])
      @issue_in_google.save
      add_activity_to_subscribers_inbox(@native_issue.create_activity :create, owner: @current_user)

      render :json => @native_issue 
    else
        render json: @native_issue.errors, status: :unprocessable_entity 
    end  
  end

  def import_update_to_native_issue_from_google_sheet

    @native_issue = IssueExistsInGoogleSheet.where(:google_sheet_id => params[:google_sheet_id], 
                                                      :external_id => params[:google_sheet_row_id]).first.native_issue   
    if @native_issue.update(:summary => params[:native_issue_summary],
                                    :description => params[:native_issue_description],
                                    :enhancement => params[:native_issue_enhancement],
                                    :added_by_id => params[:native_issue_opened_by],
                                    :issue_with_id => params[:native_issue_with_node_id]) 

      add_activity_to_subscribers_inbox(@native_issue.create_activity :update, owner: @current_user)

      render :json => @native_issue 
    else
        render json: @native_issue.errors, status: :unprocessable_entity 
    end  
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_google_sheet
      @google_sheet = GoogleSheet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def google_sheet_params
      params.require(:google_sheet).permit(:key, :name, :sheet)
    end
end
