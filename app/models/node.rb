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


end
