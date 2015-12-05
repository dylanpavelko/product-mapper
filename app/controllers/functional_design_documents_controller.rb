class FunctionalDesignDocumentsController < ApplicationController
  before_action :set_functional_design_document, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user
  before_filter :authorized_only

  # GET /functional_design_documents
  # GET /functional_design_documents.json
  def index
    @functional_design_documents = FunctionalDesignDocument.all
  end

  # GET /functional_design_documents/1
  # GET /functional_design_documents/1.json
  def show
    @has_specs = NodeHasFunctionalDesignDocument.where(:fdd_id => @functional_design_document.id)
  end

  # GET /functional_design_documents/new
  def new
    @functional_design_document = FunctionalDesignDocument.new
  end

  # GET /functional_design_documents/1/edit
  def edit
  end

  # POST /functional_design_documents
  # POST /functional_design_documents.json
  def create
    @functional_design_document = FunctionalDesignDocument.new(functional_design_document_params)

    respond_to do |format|
      if @functional_design_document.save
        format.html { redirect_to @functional_design_document, notice: 'Functional design document was successfully created.' }
        format.json { render :show, status: :created, location: @functional_design_document }
      else
        format.html { render :new }
        format.json { render json: @functional_design_document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /functional_design_documents/1
  # PATCH/PUT /functional_design_documents/1.json
  def update
    respond_to do |format|
      if @functional_design_document.update(functional_design_document_params)
        format.html { redirect_to @functional_design_document, notice: 'Functional design document was successfully updated.' }
        format.json { render :show, status: :ok, location: @functional_design_document }
      else
        format.html { render :edit }
        format.json { render json: @functional_design_document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /functional_design_documents/1
  # DELETE /functional_design_documents/1.json
  def destroy
    @functional_design_document.destroy
    respond_to do |format|
      format.html { redirect_to functional_design_documents_url, notice: 'Functional design document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_functional_design_document
      @functional_design_document = FunctionalDesignDocument.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def functional_design_document_params
      params.require(:functional_design_document).permit(:name, :url)
    end
end
