class NodeHasFunctionalDesignDocumentsController < ApplicationController
  before_action :set_node_has_functional_design_document, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user
  before_filter :authorized_only

  # GET /node_has_functional_design_documents
  # GET /node_has_functional_design_documents.json
  def index
    @node_has_functional_design_documents = NodeHasFunctionalDesignDocument.all
  end

  # GET /node_has_functional_design_documents/1
  # GET /node_has_functional_design_documents/1.json
  def show
  end

  # GET /node_has_functional_design_documents/new
  def new
    @node_has_functional_design_document = NodeHasFunctionalDesignDocument.new
    @node = Node.find(params[:format])
  end

  # GET /node_has_functional_design_documents/1/edit
  def edit
  end

  # POST /node_has_functional_design_documents
  # POST /node_has_functional_design_documents.json
  def create
    @node_has_functional_design_document = NodeHasFunctionalDesignDocument.new(node_has_functional_design_document_params)

    respond_to do |format|
      if @node_has_functional_design_document.save
        format.html { redirect_to @node_has_functional_design_document, notice: 'Node has functional design document was successfully created.' }
        format.json { render :show, status: :created, location: @node_has_functional_design_document }
      else
        format.html { render :new }
        format.json { render json: @node_has_functional_design_document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /node_has_functional_design_documents/1
  # PATCH/PUT /node_has_functional_design_documents/1.json
  def update
    respond_to do |format|
      if @node_has_functional_design_document.update(node_has_functional_design_document_params)
        format.html { redirect_to @node_has_functional_design_document, notice: 'Node has functional design document was successfully updated.' }
        format.json { render :show, status: :ok, location: @node_has_functional_design_document }
      else
        format.html { render :edit }
        format.json { render json: @node_has_functional_design_document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /node_has_functional_design_documents/1
  # DELETE /node_has_functional_design_documents/1.json
  def destroy
    @node_has_functional_design_document.destroy
    respond_to do |format|
      format.html { redirect_to node_has_functional_design_documents_url, notice: 'Node has functional design document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_node_has_functional_design_document
      @node_has_functional_design_document = NodeHasFunctionalDesignDocument.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def node_has_functional_design_document_params
      params.require(:node_has_functional_design_document).permit(:node_id, :FDD_id)
    end
end
