class Node < ActiveRecord::Base
  belongs_to :parent, class_name: "Node", foreign_key: "parent_id"
  has_many :children, class_name: 'Node', foreign_key: "parent_id"
  belongs_to :nodeType, class_name: "NodeType"
  has_many :tasks, class_name: "Task"
  has_many :questions, class_name: "Question", foreign_key: "question_id"
  has_many :phases, class_name: "Phase", foreign_key: "id"

  include RankedModel
  ranks :row_order

  def displayNameAndType
    displayName = name + nodeType.name
  end

  def getPhases(node)
  	Phases.find_by node: node
  end

  def phases
    @nodePhases = Phase.where(:node_id => self.id)
  end

  def status
    @nodePhases = Phase.where(:node_id => self.id)
    @nodePhases.each do |phase|
      if !phase.status
        return false
      end
    end
    self.children.each do |node|
      if !node.status
        return false
      end
    end
    if @nodePhases.count < 1 && self.children.count < 1
      return false
    end

      return true
  end

  def get_row_order_position
    Node.where("row_order < ?", self.row_order).count
  end

  def progress_status
    @status = "Backlog"
    @nodePhases = Phase.where(:node_id => self.id)
    #if any phase is in progress, return in progress
    @nodePhases.each do |phase|
      if phase.get_progress_status_text == "In Progress"
        return "In Progress"
      elsif phase.get_progress_status_text == "Done"
        @status = "Done"
      elsif phase.get_progress_status_text == "Backlog" and @status == "Done"
        return "Partially Done - Nothing In Progress"        
      end
    end
    self.children.each do |node|
      if node.progress_status == "In Progress"
        return "In Progress"
      elsif node.progress_status == "Done"
        @status = "Done"
      elsif node.progress_status == "Backlog" and @status == "Done"
        @status = "Partially Done/Nothing In-Progress" 
      end
    end
    if @nodePhases.count < 1 && self.children.count < 1
      @status = "Backlog"
    end

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

  def get_feature
    if self.parent.nodeType.feature 
      return self.parent
    else
      return self.parent.parent
    end
  end

  def percent_done(filters)
    @percent = 0
    kids = self.filtered_children(filters)
    if kids.count > 0
      kids.each do |child|
          @percent = @percent + child.percent_done(filters)
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

  def percent_in_progress(filters)
    @percent = 0
    kids = self.filtered_children(filters)
    if kids.count > 0
      kids.each do |child|
          @percent = @percent + child.percent_in_progress(filters)
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
      @next_date = @delivery_dates.first
      return @next_date.string
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

  def solves_issues
    NativeIssue.where(:resolved_with_id => self.id)
  end

  def open_issues
    GitHubIssue.where(:node_id => self.id) + NativeIssue.where(:issue_with_id => self.id)
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

end
