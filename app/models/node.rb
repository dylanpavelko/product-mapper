class Node < ActiveRecord::Base
  belongs_to :parent, class_name: "Node", foreign_key: "parent_id"
  has_many :children, class_name: 'Node', foreign_key: "parent_id"
  belongs_to :nodeType, class_name: "NodeType"
  has_many :tasks, class_name: "Task"
  has_many :questions, class_name: "Question", foreign_key: "question_id"
  has_many :phases, class_name: "Phase", foreign_key: "id"

  def displayNameAndType
    displayName = name + nodeType.name
  end

  def getPhases(node)
  	Phases.find_by node: node
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
        return "Partially Done/Nothing In-Progress" 
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

  def getTerminalNodeWithUncompleteStatus(completed)
    @terminalNodes = Array.new

    self.children.each do |node|
      if node.children.count == 0
        if !node.status
          puts node.status
          @terminalNodes << node
        end
      else
        node.getTerminalNodes.each do |terminalNode|
          if !terminalNode.status
            puts terminalNode.status
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
    @issues = Array.new
    @ghis = GitHubIssue.where(:node_id => self.id)
    @ghis.each do |issue|
      @issues << issue
    end
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

  def percent_done
    @percent = 0
    if self.children.count > 0
      self.children.each do |child|
          @percent = @percent + child.percent_done
      end
      @percent = @percent/self.children.count
    else
      if self.status
        @percent = 100
      else
        @percent = 0
      end
    end
    return @percent
  end

  def percent_in_progress
    @percent = 0
    if self.children.count > 0
      self.children.each do |child|
          @percent = @percent + child.percent_in_progress
      end
      @percent = @percent/self.children.count
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

end
