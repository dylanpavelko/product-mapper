class Node < ActiveRecord::Base
  include PublicActivity::Common

  belongs_to :parent, class_name: "Node", foreign_key: "parent_id"
  has_many :children, class_name: 'Node', foreign_key: "parent_id"
  belongs_to :nodeType, class_name: "NodeType"
  has_many :tasks, class_name: "Task"
  has_many :questions, class_name: "Question", foreign_key: "question_id"
  has_many :phases, class_name: "Phase", foreign_key: "id"
  has_many :fdds, class_name: "FunctionalDesignDocument", foreign_key: "id"
  belongs_to :organization, class_name: "Organization", foreign_key: "organization_id"
  has_many :efforts, class_name: "Effort", foreign_key: "node_id"
  

  @fchildren = Array.new

  @percent_done
  @percent_in_progress

  validates :nodeType, :organization_id, :presence => true

  include RankedModel
  ranks :row_order

  def displayNameAndType
    displayName = name + " [" + nodeType.name + "]"
  end

  def getPhases(node)
  	Phases.find_by node: node
  end

  def phases
    @nodePhases = Phase.where(:node_id => self.id)
  end

  def team_members
    @users_has_roles_for_node = UserHasRoleForNode.where(:node_id => self.id)
  end

  def fdds
    @has_fdds = NodeHasFunctionalDesignDocument.where(:node_id => self.id)
    @fdds = Array.new
    if @has_fdds != nil
      @has_fdds.each do |has_fdd|
        @fdds << has_fdd.FDD
      end
    end
    return @fdds
  end

  def status
    # @nodePhases = self.phases
    # @nodePhases.each do |phase|
    #   if !phase.status
    #     return false
    #   end
    # end
    if self.dev_status == 1
      return true
    end

    self.children.each do |node|
      if !node.status
        return false
      end
    end
    if self.children.count < 1
      return false
    end

      return true
  end

  def get_row_order_position
    Node.where("row_order < ?", self.row_order).count
  end

  def get_node_in_position(position)
    @nodes = Node.select {|x| x.get_row_order_position == position}
    return @nodes.first
  end

  def progress_status
    @status = "Backlog"
    if self.dev_status == 1
      @status = "Done"
    elsif self.dev_status == 2
      @status = "In Progress"
    elsif self.dev_status == 3
      @status = "Partially Done - Nothing In Progress"
    end
    # @nodePhases = self.phases
    # #if any phase is in progress, return in progress
    # @nodePhases.each do |phase|
    #   if phase.get_progress_status_text == "In Progress"
    #     return "In Progress"
    #   elsif phase.get_progress_status_text == "Done"
    #     @status = "Done"
    #   elsif phase.get_progress_status_text == "Backlog" and @status == "Done"
    #     return "Partially Done - Nothing In Progress"        
    #   end
    # end
    self.children.each do |node|
      if node.progress_status == "In Progress"
        return "In Progress"
      elsif node.progress_status == "Done"
        @status = "Done"
      elsif node.progress_status == "Backlog" and @status == "Done"
        @status = "Partially Done/Nothing In-Progress" 
      end
    end
    # if self.children.count < 1
    #   @status = "Backlog"
    # end
    
    return @status
  end

  def statusInParens
    if self.status
      return "(Done)"
    else
      return ""
    end
  end

  def getTerminalNodes
    @terminalNodes = Array.new
    self.children.each do |node|
      if node.children.count == 0
        @terminalNodes << node
      else
        node.getTerminalNodes.each do |terminalNode|
        @terminalNodes << terminalNode#get the children and find their terminal nodes
        #add each item from their terminal nodes to this terminal nodes array
        end
      end
    end
    return @terminalNodes
  end

  def meets_filters(filters)
    filters.each do |filter|
      if filter[0] == 1 #MILESTONE FILTER
        milestone_date = Milestone.find(filter[1]).date
        #node_dates = DeliveryDate.where(:node_id => self.id) #get the delivery dates for the node
        if self.get_earliest_delivery_date != nil                            #if there are delivery dates
          #node_dates.each do |delivery_date|
          #  puts self.name + " targeted to " + delivery_date.milestone.date.strftime("%m/%d/%Y") + " vs " + milestone_date.strftime("%m/%d/%Y")
            if self.get_earliest_delivery_date <= milestone_date #but the delivery date is greater than the filter milestone date
              return true
            else
              return false
            end
          #end
        else
          return false
        end
      end
    end
    return true
  end

  def getFilteredTerminalNodeWithUncompleteStatus(completed, filters)
    @terminalNodes = Array.new

    self.children.each do |node|
      if node.children.count == 0
        if !node.status and node.meets_filters(filters)
          @terminalNodes << node
        end
      else
        node.getTerminalNodes.each do |terminalNode|
          if !terminalNode.status and terminalNode.meets_filters(filters)
            @terminalNodes << terminalNode
          end          
        end
      end
    end
    return @terminalNodes
  end

  def getAllSubIssues
    @subIssues = Array.new
    self.children.each do |node|
      node.getAllIssues.each do |issue|
        @subIssues << issue
      end
    end
    return @subIssues
  end

  def getAllIssues
    @issues = GitHubIssue.where(:node_id => self.id) + NativeIssue.where(:issue_with_id => self.id)

    if self.children.count > 0
      self.children.each do |childNode|
        childNode.getAllIssues.each do |issue| 
          @issues << issue
        end
      end
    end
    return @issues
  end

  def getAllSubQuestions
    @asks = Array.new
    if self.children.count > 0
      self.children.each do |childNode|
        childNode.getAllQuestions.each do |question| 
          @asks << question
        end
      end
    end
    return @asks
  end


  def getAllQuestions()
    @asks = Question.where(:node_id => self.id) + Array.new
    if self.children.count > 0
      self.children.each do |childNode|
        childNode.getAllQuestions.each do |question| 
          @asks << question
        end
      end
    end
    return @asks
  end
  
  def getAllSubNodeIDs()
    @ids = Array.new
    self.children.each do |childNode|
          @ids << childNode.id
    end
    return @ids
  end

  def getAllOpenQuestions()
    @asks = Question.where("node_id = ? AND resolved_id <> ?", self.id, '1') + Array.new
    if self.children.count > 0
      self.children.each do |childNode|
        childNode.getAllOpenQuestions.each do |question| 
          @asks << question
        end
      end
    end
    return @asks
  end

  def get_feature
    if self.parent.nodeType.feature 
      return self.parent
    else
      return self.parent.parent
    end
  end

  def calc_percent_done
    @percent = 0
    kids = self.fchildren
    if kids != nil and kids.count > 0
      kids.each do |child|
          @percent = @percent + child.percent_done
      end
      @percent = @percent/kids.count
    else
      if self.status
        @percent = 100
      else
        @percent = 0
      end
    end
    return @percent
  end

  def calc_percent_in_progress
    @percent = 0
    kids = self.fchildren
    if kids != nil and kids.count > 0
      kids.each do |child|
          @percent = @percent + child.percent_in_progress
      end
      @percent = @percent/kids.count
    else
      if self.progress_status == "In Progress"
        @percent = 100
      else
        @percent = 0
      end
    end
    return @percent
  end

  def get_next_delivery
    @delivery_dates = DeliveryDate.where(:node_id => self.id)
    if @delivery_dates.count > 0 
      @delivery_dates = @delivery_dates.sort { |a,b| a.milestone.date <=> b.milestone.date }
      @next_date = @delivery_dates.first
      return @next_date
    end
    return nil
  end

  def get_next_delivery_for_environment(environment)
    @delivery_dates = DeliveryDate.where(:node_id => self.id, :envrionment_id => environment)
    if @delivery_dates.count > 0 
      @next_date = @delivery_dates.first
      return @next_date
    end
    return nil
  end

  def phases_dependencies
    @dependencies = Array.new
    if self.phases.count > 0
      self.phases.each do |phase|
        @dependencies = @dependencies + phase.dependencies
      end
    end
    return @dependencies
  end

  def nodes_dependencies
    @dependencies = Array.new
    self.children.each do |child|
      @dependencies = @dependenceis + child.dependencies
    end
    return @dependencies
  end

  def dependencies
    return self.phases_dependencies + self.nodes_dependencies
  end

  def get_highest_priority_dependency
    @my_dependencies = self.dependencies
    if self.dependencies.count > 0
      return @my_dependencies.first.phase.node.id
    end
  end

  def solves_issues
    NativeIssue.where(:resolved_with_id => self.id)
  end

  def open_issues
    GitHubIssue.where(:node_id => self.id) + NativeIssue.where(:issue_with_id => self.id)
  end

  def features
    @features = Array.new
    self.children.each do |child|
      if child.nodeType.feature
        @features << child
      end
      if child.children.count > 0
        @features = @features + child.features
      end
    end
    return @features
  end

  def filtered_children(filters)
    filtered = Array.new
    self.children.each do |child|
      if child.meets_filters(filters)
        filtered << child
      end
    end
    return filtered
  end

  def get_earliest_delivery_date
    if self.nodeType.specification
      node_dates = DeliveryDate.where(:node_id => self.id) 
      if node_dates.count > 1
        node_dates = node_dates.sort { |a,b| a.milestone.date <=> b.milestone.date }
        return node_dates.first.milestone.date
      elsif node_dates.count == 1
        return node_dates.first.milestone.date
      else
        return nil
      end
    else
      all_filtered_dates = Array.new
      self.children.each do |child|
        if child.get_earliest_delivery_date != nil
          all_filtered_dates << child.get_earliest_delivery_date
        end
      end
      if all_filtered_dates.count > 1
        all_filtered_dates.sort! { |a,b| a <=> b }
        return all_filtered_dates.first
      elsif all_filtered_dates.count == 1
        return all_filtered_dates.first
      else
        return nil
      end
    end
  end

  def get_lastest_delivery_date
  end

  def set_deep_filtered_node(filters)
    self.filtered_children2(filters)
  end

  def deep_filtered_node(filters)
    self.filtered_children2(filters)
    return self
  end

  def filtered_children2(filters)
    self.children.each do |child|
      if child.nodeType.specification
        #check to see if it meets filter
        if child.spec_meets_filters(filters)
          self.add_filtered_child(child) #if it does add it as a filtered child
        end
      else #if it is not a specification you need to look down until you find one and set each filtered node
        child.set_deep_filtered_node(filters)
        if child.fchildren != nil and child.fchildren.count != 0
          #then there were children that matched the filter and this should be included in filtered children
          self.add_filtered_child(child)
        elsif filters.count == 0
          self.add_filtered_child(child)
        end
      end
    end
  end

  def add_filtered_child(node)
    if @fchildren == nil 
      @fchildren = Array.new
    end
    kids = self.fchildren 
    node.set_perecent_done(node.calc_percent_done)
    node.set_perecent_in_progress(node.calc_percent_in_progress)
    kids << node

    self.set_fchildren(kids)
  end

  def get_earliest_date_of_spec
      node_dates = DeliveryDate.where(:node_id => self.id) 
      if node_dates.count > 1
        node_dates = node_dates.sort { |a,b| a.milestone.date <=> b.milestone.date }
        return node_dates.first.milestone.date
      elsif node_dates.count == 1
        return node_dates.first.milestone.date
      else
        return nil
      end
  end

  def spec_meets_filters(filters)
      filters.each do |filter|
        if filter[0] == 1 #MILESTONE FILTER
          milestone_date = Milestone.find(filter[1]).date
          #node_dates = DeliveryDate.where(:node_id => self.id) #get the delivery dates for the node
          if self.get_earliest_date_of_spec != nil                            #if there are delivery dates
            #node_dates.each do |delivery_date|
            #  puts self.name + " targeted to " + delivery_date.milestone.date.strftime("%m/%d/%Y") + " vs " + milestone_date.strftime("%m/%d/%Y")
              if self.get_earliest_date_of_spec <= milestone_date #but the delivery date is greater than the filter milestone date
                return true
              else
                return false
              end
            #end
          else
            return false
          end
        end
      end
      return true
  end

  def fchildren
    @fchildren
  end

  def set_fchildren(nodes)
    @fchildren = nodes
  end

  def set_perecent_done(done)
    @percent_done = done
  end

  def percent_done
    @percent_done
  end

  def set_perecent_in_progress(in_progress)
    @percent_in_progress = in_progress
  end

  def percent_in_progress
    @percent_in_progress
  end

  def reset_feature_spec_node_status
    @in_progress = false
    @done = true
    if self.nodeType.specification
      self.phases.each do |phase|
        if phase.progress_status == 2
          @in_progress = true
        end
        if !phase.status
          @done = false
        end
      end
    

    if @in_progress
      self.update(:dev_status => 2)
    elsif @done
      self.update(:dev_status => 1)
    else
      self.update(:dev_status => nil)
    end
    end
  end

  def matches(search_string)
    @search_pieces = search_string.split(' ')
    @search_pieces.each do |word|
      if !self.name.downcase.include? word.downcase
        return false
      end
    end
    return true
  end

  def belongs_to_product
    if self.nodeType.product 
      return self
    elsif self.nodeType.feature or self.nodeType.specification
      @i = self
      @parents = Array.new
      while @i.parent != nil do 
        @parents << @i.parent
        @i = @i.parent
      end
      @parents.each do |parent|
        if parent.nodeType.product
          return parent
        end
      end
    end
    return nil
  end

  def parents
    @parents = Array.new
    @i = self
    while @i.parent != nil do 
      @parents << @i.parent
      @i = @i.parent
    end
    return @parents
  end

  def get_closest_pm
    @pms = Array.new
    @users = UserHasRoleForNode.where(:node => self.id)
    
    @users.each do |has_role|
      if has_role.role.edit_nodes
        @pms << has_role.user
      end
    end
    if @pms.count > 0
      return @pms.first
    elsif self.parent == nil
      return nil
    else
      return self.parent.get_closest_pm
    end
  end

  def get_non_pms
    @user_roles = UserHasRoleForNode.where(:node => self.id)
    @non_pms = Array.new
    @user_roles.each do |has_role|
      if ! has_role.role.edit_nodes
        @non_pms << has_role.user
      end
    end
    return @non_pms
  end

end
