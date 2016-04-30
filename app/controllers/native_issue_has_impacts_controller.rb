class NativeIssueHasImpactsController < ApplicationController
  before_action :set_native_issue_has_impact, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user
  before_filter :authorized_only

  # GET /native_issue_has_impacts
  # GET /native_issue_has_impacts.json
  def index
    @native_issue_has_impacts = NativeIssueHasImpact.all
  end

  # GET /native_issue_has_impacts/1
  # GET /native_issue_has_impacts/1.json
  def show
  end

  # GET /native_issue_has_impacts/new
  def new
    @native_issue_has_impact = NativeIssueHasImpact.new
  end

  # GET /native_issue_has_impacts/1/edit
  def edit
  end

  # POST /native_issue_has_impacts
  # POST /native_issue_has_impacts.json
  def create
    @native_issue_has_impact = NativeIssueHasImpact.new(native_issue_has_impact_params)

    respond_to do |format|
      if @native_issue_has_impact.save
        format.html { redirect_to @native_issue_has_impact, notice: 'Native issue has impact was successfully created.' }
        format.json { render :show, status: :created, location: @native_issue_has_impact }
      else
        format.html { render :new }
        format.json { render json: @native_issue_has_impact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /native_issue_has_impacts/1
  # PATCH/PUT /native_issue_has_impacts/1.json
  def update
    respond_to do |format|
      if @native_issue_has_impact.update(native_issue_has_impact_params)
        format.html { redirect_to @native_issue_has_impact, notice: 'Native issue has impact was successfully updated.' }
        format.json { render :show, status: :ok, location: @native_issue_has_impact }
      else
        format.html { render :edit }
        format.json { render json: @native_issue_has_impact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /native_issue_has_impacts/1
  # DELETE /native_issue_has_impacts/1.json
  def destroy
    @native_issue_has_impact.destroy
    respond_to do |format|
      format.html { redirect_to native_issue_has_impacts_url, notice: 'Native issue has impact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_native_issue_has_impact
      @native_issue_has_impact = NativeIssueHasImpact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def native_issue_has_impact_params
      params.require(:native_issue_has_impact).permit(:customer_id, :native_issue_id, :impact)
    end
end
