class NodeHasThemesController < ApplicationController
  before_action :set_node_has_theme, only: [:show, :edit, :update, :destroy]
        before_filter :authenticate_user
    before_filter :authorized_only

  # GET /node_has_themes
  # GET /node_has_themes.json
  def index
    @node_has_themes = NodeHasTheme.all
  end

  # GET /node_has_themes/1
  # GET /node_has_themes/1.json
  def show
  end

  # GET /node_has_themes/new
  def new
    @node = Node.find(params[:format])
    @node_has_theme = NodeHasTheme.new(:node_id => @node.id)
  end

  # GET /node_has_themes/1/edit
  def edit
  end

  # POST /node_has_themes
  # POST /node_has_themes.json
  def create
    @node_has_theme = NodeHasTheme.new(node_has_theme_params)

    respond_to do |format|
      if @node_has_theme.save
        format.html { redirect_to @node_has_theme.node, notice: 'Node has theme was successfully created.' }
        format.json { render :show, status: :created, location: @node_has_theme }
      else
        format.html { render :new }
        format.json { render json: @node_has_theme.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /node_has_themes/1
  # PATCH/PUT /node_has_themes/1.json
  def update
    respond_to do |format|
      if @node_has_theme.update(node_has_theme_params)
        format.html { redirect_to @node_has_theme, notice: 'Node has theme was successfully updated.' }
        format.json { render :show, status: :ok, location: @node_has_theme }
      else
        format.html { render :edit }
        format.json { render json: @node_has_theme.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /node_has_themes/1
  # DELETE /node_has_themes/1.json
  def destroy
    @node = @node_has_theme.node
    @node_has_theme.destroy
    respond_to do |format|
      format.html { redirect_to @node, notice: 'Node has theme was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_node_has_theme
      @node_has_theme = NodeHasTheme.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def node_has_theme_params
      params.require(:node_has_theme).permit(:node_id, :theme_id)
    end
end
