class NativeIssueHasAsanasController < ApplicationController
  before_action :set_native_issue_has_asana, only: [:show, :edit, :update, :destroy]
            before_filter :authenticate_user
    before_filter :authorized_only

  # GET /native_issue_has_asanas
  # GET /native_issue_has_asanas.json
  def index
    @native_issue_has_asanas = NativeIssueHasAsana.all
  end

  # GET /native_issue_has_asanas/1
  # GET /native_issue_has_asanas/1.json
  def show
  end

  # GET /native_issue_has_asanas/new
  def new
    @native_issue_has_asana = NativeIssueHasAsana.new
  end

  # GET /native_issue_has_asanas/1/edit
  def edit
  end

  # POST /native_issue_has_asanas
  # POST /native_issue_has_asanas.json
  def create
    @native_issue_has_asana = NativeIssueHasAsana.new(native_issue_has_asana_params)

    respond_to do |format|
      if @native_issue_has_asana.save
        format.html { redirect_to @native_issue_has_asana, notice: 'Native issue has asana was successfully created.' }
        format.json { render :show, status: :created, location: @native_issue_has_asana }
      else
        format.html { render :new }
        format.json { render json: @native_issue_has_asana.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /native_issue_has_asanas/1
  # PATCH/PUT /native_issue_has_asanas/1.json
  def update
    respond_to do |format|
      if @native_issue_has_asana.update(native_issue_has_asana_params)
        format.html { redirect_to @native_issue_has_asana, notice: 'Native issue has asana was successfully updated.' }
        format.json { render :show, status: :ok, location: @native_issue_has_asana }
      else
        format.html { render :edit }
        format.json { render json: @native_issue_has_asana.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /native_issue_has_asanas/1
  # DELETE /native_issue_has_asanas/1.json
  def destroy
    @native_issue_has_asana.destroy
    respond_to do |format|
      format.html { redirect_to native_issue_has_asanas_url, notice: 'Native issue has asana was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_native_issue_has_asana
      @native_issue_has_asana = NativeIssueHasAsana.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def native_issue_has_asana_params
      params.require(:native_issue_has_asana).permit(:asana_task_id, :native_issue_id)
    end
end
