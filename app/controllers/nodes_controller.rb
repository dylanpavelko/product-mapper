class NodesController < ApplicationController
  before_filter :authenticate_user
  before_filter :authorized_only

  def index
    @node = Node.all
  end

  def new
    if params.has_key?(:format)
      @origin_node = Node.find(params[:format])
    end
    @node = Node.new
  end

  def create
    @node = Node.new(node_params)
    if @node.save
          @phasesParams = params[:phaseType][:id]
          @phasesParams.shift
          @nodePhaseTypes = PhaseType.find(@phasesParams)
          @nodePhaseTypes.each do |phaseType|
            if (phaseType != nil)
              add_phase_if_needed(@node, phaseType)
            end  
          end
       redirect_to @node
    else
       render :new
    end
  end

  def show
    @node = Node.find(params[:id])
    @nodePhases = Phase.where(:node_id => @node)
    @nodeDeepPhases = Array.new
    @nodeQuestions = Question.where(:node_id => @node)
    @issues = GitHubIssue.where(:node_id => @node) + NativeIssue.where(:issue_with_id => @node)
    @subIssues = @node.getAllSubIssues()

    @subPhases = Phase.where(:node_id => @subIssues)
    @delivery_dates = DeliveryDate.where(:node_id => @node)
    @all_delivery_dates = DeliveryDate.where(:node_id => @subIssues)


  end

  def feature_inventory
      @node = Node.find(params[:id])
      @terminalNodes = @node.getTerminalNodes()
      @terminalNodes = @terminalNodes.sort_by {|obj| [obj.status ? 0 : 1 , obj.row_order ] }

  end

  def backlog
      if Node.all.first.row_order == nil
        Node.all.each do |n|
          n.update_attribute :row_order_position, :last
        end
      end
      @node = Node.find(params[:id])
      Node.rank(:row_order).all
      status = false;
      @terminalNodes = @node.getTerminalNodeWithUncompleteStatus(status)
      @terminalNodes = @terminalNodes.sort_by {|obj| obj.row_order}
   #   @terminalBacklogNodes
  end

  def edit
    @node = Node.find(params[:id])
  end

  def update
    @node = Node.find(params[:id])
    @phasesParams = params[:phaseType][:id]
    @phasesParams.shift
    @nodePhaseTypes = PhaseType.find(@phasesParams)
    @nodePhaseTypes.each do |phaseType|
      if (phaseType != nil)
        add_phase_if_needed(@node, phaseType)
      end  
    end
    if @node.update_attributes(node_params)
      redirect_to @node
    else
      render :edit
    end
  end

  def index
    @nodes = Node.all
  end

  def update_row_order
    @node = Node.find(node_params[:node_id])
    @node.row_order_position = node_params[:row_order_position]
    @node.save

    render nothing: true # this is a POST action, updates sent via AJAX, no view rendered
  end

  private
    def node_params
      params.require(:node).permit(:name, :node_id, :parent_id, :nodeType_id, :phaseTypes, :description, :row_order_position)
    end

  private
    def add_phase_if_needed(node, phaseType)
      @phase = Phase.where(node_id: @node.id, phaseType_id: phaseType.id).first_or_create
    end  

end
