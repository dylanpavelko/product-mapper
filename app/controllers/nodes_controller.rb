class NodesController < ApplicationController
  before_filter :authenticate_user
  before_filter :authorized_only

  def index
    @nodes = Node.all.select { |n| n.nodeType.product? == true }.sort { |x, y| x.id <=> y.id }
  end

  def new
    if params.has_key?(:format)
      @origin_node = Node.find(params[:format])
    end
    @node = Node.new

    @parents = Array.new
    @i = @origin_node

    if @i != nil 
      @node.parent = @origin_node
      while @i.parent != nil do 
        @parents << @i.parent
        @i = @i.parent
      end
    end
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
      add_activity_to_subscribers_inbox(@node.create_activity :create, owner: @current_user)

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
    @node = Node.find(params[:id])
    @fdds = NodeHasFunctionalDesignDocument.where(:node_id => @node)
    @nodePhases = Phase.where(:node_id => @node)
    @nodeDeepPhases = Array.new


    @subNodeIds = @node.getAllSubNodeIDs()  #ALL subnodes is just getting top level subnodes
    @allNodeIds = @subNodeIds << @node.id
    
    @subNodes = Node.where(id: @subNodeIds)
    @related_development_phases = Phase.where(node_id: @subNodeIds)
    
    if @node.nodeType.specification or @node.nodeType.feature 
      @nodeQuestions = Question.where(:node_id => @node)
      @subQuestions = Question.where(node_id: @subNodeIds)
      @issues = GitHubIssue.where(:node_id => @node) + NativeIssue.where(:issue_with_id => @node)
      @subIssues = GitHubIssue.where(node_id: @subNodeIds) + NativeIssue.where(issue_with_id: @subNodeIds)
    else
      @nodeQuestions = Question.where(node_id: @allNodeIds)
      @issues = GitHubIssue.where(node_id: @allNodeIds) + NativeIssue.where(issue_with_id: @allNodeIds)
    end
    
    @issue_resolutions = NativeIssue.where(:resolved_with_id => @node)

    @subPhases = Phase.where(:node_id => @subIssues)
    @delivery_dates = DeliveryDate.where(:node_id => @node)
    @all_delivery_dates = DeliveryDate.where(:node_id => @subIssues)

    @has_Themes = NodeHasTheme.where(:node_id => @node)
    @node_effort = Effort.where(:node_id => @node)
    @node_priority = Priority.where(:node_id => @node)
    
  end

  def feature_inventory
      @hide_completed = params[:hide_completed]
      @granularity = params[:granularity]
      @node = Node.find(params[:id])
      @terminalNodes = @node.getTerminalNodes()
      @marker_node_type = NodeType.where(:marker => true)
      if @marker_node_type.count > 0
        @markers = Node.where(:nodeType_id => @marker_node_type.first.id)
      end
      @terminalNodes = @markers + @terminalNodes
      @terminalNodes = @terminalNodes.sort_by {|obj| [obj.status ? 0 : 1 , obj.row_order ] }
      if @hide_completed == "true"
        @terminalNodes = @terminalNodes.select {|s| !s.status }
      end
  end

  def in_progress
    @in_progress_phases = Phase.where(:progress_status => '2')

    @in_progress_phases = @in_progress_phases.sort_by {|phase| [phase.node.belongs_to_product, phase.node.parent.name]}

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
    @marker_node_type = NodeType.where(:marker => true)
    @markers = Array.new
    if @marker_node_type.count > 0
      @markers = Node.where(:nodeType_id => @marker_node_type.first.id)
    end
    @terminalNodes = @markers + @terminalNodes
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

  def team
    @node = Node.find(params[:id])
    @features = @node.features

    @unassigned_features = Array.new
    @features.delete_if do |feature|
      if feature.team_members.count == 0
        @unassigned_features << feature
        true
      end
    end

    @features.sort! { |a,b| [a.team_members.first.user, a.name] <=> [b.team_members.first.user, b.name]}
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
      add_activity_to_subscribers_inbox(@node.create_activity :update, owner: @current_user)
      @log = NodeHistory.new(:user_id => @current_user.id, :node_id => @node.id,
        :log => "Updated the product node ")
      @log.save
      
      redirect_to @node
    else
      render :edit
    end
  end

  def update_row_order
    @node_ids = params[:node][:node_id]
    @position = node_params[:row_order_position]

    @id_above = node_params[:row_above]
    @id_below = node_params[:row_below]

    if @id_below != "NaN"
      @below_position = Node.find(@id_below).get_row_order_position
    end
    if @id_above != "NaN"
      @above_position = Node.find(@id_above).get_row_order_position
    else 
      @above_position = @below_position - 1
    end

    @position = @above_position;
    @prior_position = Node.find(@node_ids.first).get_row_order_position;

    if @prior_position >= @position
      @position = @position + 1
    elsif @prior_position < @position
      @position = @position 
    else
      @position = @below_position
    end


    if Node.find(@node_ids.first).get_row_order_position >= @position.to_i 
      @node_ids = @node_ids.reverse
    end

    @node_ids.each do |node_id|
      @node = Node.find(node_id)
      @node.row_order_position = @position
      @position = @position.to_i 


      @prior_rank = @node.get_row_order_position
      @node.save
      @new_rank = @node.get_row_order_position
      @above_node = @node.get_node_in_position(@new_rank + 1)
      if @above_node == nil
        @below_node = @node.get_node_in_position(@new_rank - 1)
         @node_log = NodeHistory.new(:node_id => @node.id, :user_id => @current_user.id, 
        :log_type => 1, :log => ("Updated Priority from " + @prior_rank.to_s + " to " + @new_rank.to_s + " below " + @below_node.name),
        :other_node_id => @below_node.id )
      else
        @node_log = NodeHistory.new(:node_id => @node.id, :user_id => @current_user.id, 
        :log_type => 1, :log => ("Updated Priority from " + @prior_rank.to_s + " to " + @new_rank.to_s + " above " + @above_node.name),
        :other_node_id => @above_node.id )
      end
      @node_log.save

    end

    @data = 1
    render json: @data # this is a POST action, updates sent via AJAX, no view rendered
  end

  def search_results
    @search_string = params[:str]
    puts "this is the search string"
    puts @search_string
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

    @phases = Phase.where(:node_id => @primary_node.id)
    @phases_lite = Array.new
    @phases.each do |p|
      @phases_lite << {:id => p.id, :name => p.phaseType.name}
    end

    @data = {:node => @primary_node_lite,
             :parents => @parents_lite, 
             :children => @children_lite,
             :phases => @phases_lite}

    respond_to do |format|
      format.html
      format.json {render json: @data }
    end
  end

  def destroy
    @node = Node.find(params[:id])
    @node.destroy
    respond_to do |format|
      format.html { redirect_to nodes_path, notice: 'Phase type default has phyase type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def node_params
      params.require(:node).permit(:name, :node_id, :parent_id, :nodeType_id, :phaseTypes, :description, :row_order_position, :row_above, :row_below, :organization_id)
    end

  private
    def add_phase_if_needed(node, phaseType)
      @phase = Phase.where(node_id: @node.id, phaseType_id: phaseType.id).first_or_create
    end  

end
