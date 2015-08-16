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
    @nodeQuestions = Question.where(:node_id => @node)
  end

  def backlog
      @node = Node.find(params[:id])
      @terminalNodes = @node.getTerminalNodes
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

  private
    def node_params
      params.require(:node).permit(:name, :parent_id, :nodeType_id, :phaseTypes, :description)
    end

  private
    def add_phase_if_needed(node, phaseType)
      @phase = Phase.where(node_id: @node.id, phaseType_id: phaseType.id).first_or_create
    end  

end
