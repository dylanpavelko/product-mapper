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
      # @phasesParams = params[:phaseType][:id]
      # @phasesParams.shift
      # @nodePhaseTypes = PhaseType.find(@phasesParams)
      # @nodePhaseTypes.each do |phaseType|
      #   if (phaseType != nil)
      #     add_phase_if_needed(@node, phaseType)
      #   end  
      # end
      if @node.nodeType.specification
        #create a development phase for spec
        @development_phase_type = PhaseType.where(:name => "Development").first
        add_phase_if_needed(@node, @development_phase_type)
      end

      @log = NodeHistory.new(:user_id => @current_user.id, :node_id => @node.id, :other_node_id => @node.parent_id,
        :log => "Created Product Node as a part of ", :log_type => 2)
      @log.save
      @log2 = NodeHistory.new(:user_id => @current_user.id, :node_id => @node.parent_id, :other_node_id => @node.id,
        :log => "Added the child product node ", :log_type => 2)
      @log2.save


      redirect_to @node
    else
       render :new
    end
  end

  def show
    # Node.all.each do |this_node|
    #   if this_node.nodeType.specification
    #     @node_status = true
    #     this_node.phases.each do |phase|
    #       if !phase.status
    #         @node_status = false
    #       end
    #     end
    #     if this_node.phases.count < 1
    #       @node_status = false
    #     end
    #     if @node_status
    #       this_node.update(:dev_status => 1)
    #     else
    #       this_node.update(:dev_status => nil)
    #     end
    #   end
    # end

    # Node.all.each do |this_node|
    #   if this_node.nodeType.specification
    #     if this_node.progress_status == "In Progress"
    #       this_node.update(:dev_status => 2)
    #     end
    #   end
    # end

    @node = Node.find(params[:id])
    @fdds = NodeHasFunctionalDesignDocument.where(:node_id => @node)
    @nodePhases = Phase.where(:node_id => @node)
    @nodeDeepPhases = Array.new
    @nodeQuestions = Question.where(:node_id => @node)
    @issues = GitHubIssue.where(:node_id => @node) + NativeIssue.where(:issue_with_id => @node)
    @subIssues = @node.getAllSubIssues()
    @issue_resolutions = NativeIssue.where(:resolved_with_id => @node)

    @subPhases = Phase.where(:node_id => @subIssues)
    @delivery_dates = DeliveryDate.where(:node_id => @node)
    @all_delivery_dates = DeliveryDate.where(:node_id => @subIssues)


  end

  def feature_inventory
      @node = Node.find(params[:id])
      @terminalNodes = @node.getTerminalNodes()
      @terminalNodes = @terminalNodes.sort_by {|obj| [obj.status ? 0 : 1 , obj.row_order ] }

  end

  def delivery_schedule
      @node = Node.find(params[:id])
      @terminalNodes = @node.getTerminalNodes()
      @terminalNodes = @terminalNodes.sort_by {|obj| [obj.status ? 0 : 1 , obj.row_order ] }
  end

  def backlog
    @filters = session[:filters]
    if @filters == nil
      @filters = Array.new
    end
    if Node.all.first.row_order == nil
      Node.all.each do |n|
        n.update_attribute :row_order_position, :last
      end
    end
    @node = Node.find(params[:id])
    Node.rank(:row_order).all
    status = false;
    @terminalNodes = @node.getFilteredTerminalNodeWithUncompleteStatus(status, @filters)
    @terminalNodes = @terminalNodes.sort_by {|obj| obj.row_order}
   #   @terminalBacklogNodes
  end

  def edit
    @node = Node.find(params[:id])

    @parents = Array.new
    @i = @node
    while @i.parent != nil do 
      @parents << @i.parent
      @i = @i.parent
    end
  end

  def update
    @node = Node.find(params[:id])
    # @phasesParams = params[:phaseType][:id]
    # @phasesParams.shift
    # @nodePhaseTypes = PhaseType.find(@phasesParams)
    # @nodePhaseTypes.each do |phaseType|
    #   if (phaseType != nil)
    #     add_phase_if_needed(@node, phaseType)
    #   end  
    # end
    if @node.update_attributes(node_params)
      @log = NodeHistory.new(:user_id => @current_user.id, :node_id => @node.id,
        :log => "Updated the product node ")
      @log.save
      
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
    @prior_rank = @node.get_row_order_position
    @node.row_order_position = node_params[:row_order_position]
    @node.save
    @new_rank = @node.get_row_order_position
    @above_node = @node.get_node_in_position(74)
    @node_log = NodeHistory.new(:node_id => @node.id, :user_id => @current_user.id, 
      :log_type => 1, :log => ("Updated Priority from " + @prior_rank.to_s + " to " + @new_rank.to_s + " above " + @above_node.name),
      :other_node_id => @above_node.id )
    @node_log.save

    render nothing: true # this is a POST action, updates sent via AJAX, no view rendered
  end

  def chooser_get
    @primary_node = Node.find(params[:id])
    @primary_node_lite = { :id => @primary_node.id, :name => @primary_node.name}

    #get parents
    @parents = Array.new
    @i = @primary_node
    while @i.parent != nil do 
      @parents << @i.parent
      @i = @i.parent
    end

    @parents_lite = Array.new
    @parents.reverse_each do |p|
      @parents_lite << {:id => p.id, :name => p.name}
    end

    #get kids
    @children = @primary_node.children
    @children_lite = Array.new
    @children.each do |c|
      if c.children != nil and c.children.count > 0
        @children_lite << {:id => c.id, :name => c.name, :has_kids => true}
      else
        @children_lite << {:id => c.id, :name => c.name, :has_kids => false}
      end
    end

    @data = {:node => @primary_node_lite,
             :parents => @parents_lite, 
             :children => @children_lite}

    respond_to do |format|
      format.html
      format.json {render json: @data }
    end
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
