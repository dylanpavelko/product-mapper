class UserHasRoleForNodesController < ApplicationController
  before_action :set_user_has_role_for_node, only: [:show, :edit, :update, :destroy]
      before_filter :authenticate_user
    before_filter :authorized_only

  # GET /user_has_role_for_nodes
  # GET /user_has_role_for_nodes.json
  def index
    @user_has_role_for_nodes = UserHasRoleForNode.all
  end

  # GET /user_has_role_for_nodes/1
  # GET /user_has_role_for_nodes/1.json
  def show
  end

  # GET /user_has_role_for_nodes/new
  def new
    @user_has_role_for_node = UserHasRoleForNode.new
  end

  # GET /user_has_role_for_nodes/1/edit
  def edit
  end

  # POST /user_has_role_for_nodes
  # POST /user_has_role_for_nodes.json
  def create
    @user_has_role_for_node = UserHasRoleForNode.new(user_has_role_for_node_params)

    respond_to do |format|
      if @user_has_role_for_node.save
        format.html { redirect_to @user_has_role_for_node, notice: 'User has role for node was successfully created.' }
        format.json { render :show, status: :created, location: @user_has_role_for_node }
      else
        format.html { render :new }
        format.json { render json: @user_has_role_for_node.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_has_role_for_nodes/1
  # PATCH/PUT /user_has_role_for_nodes/1.json
  def update
    respond_to do |format|
      if @user_has_role_for_node.update(user_has_role_for_node_params)
        format.html { redirect_to @user_has_role_for_node, notice: 'User has role for node was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_has_role_for_node }
      else
        format.html { render :edit }
        format.json { render json: @user_has_role_for_node.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_has_role_for_nodes/1
  # DELETE /user_has_role_for_nodes/1.json
  def destroy
    @user_has_role_for_node.destroy
    respond_to do |format|
      format.html { redirect_to user_has_role_for_nodes_url, notice: 'User has role for node was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_has_role_for_node
      @user_has_role_for_node = UserHasRoleForNode.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_has_role_for_node_params
      params.require(:user_has_role_for_node).permit(:user_id, :role_id, :node_id)
    end
end
