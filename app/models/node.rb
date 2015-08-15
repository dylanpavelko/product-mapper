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
    if self.children.count > 0
    else
      @nodePhases = Phase.where(:node_id => self.id)
      @nodePhases.each do |phase|
        if !phase.status
          return false
        end
      end
      if @nodePhases.count < 1
        puts "test"
        puts self.phases.count
        return false
      end
      return true
    end

    # if self.children.count > 0
    #   self.children.each do |child|
    #     if child.phase != nil
    #       if !child.phase.status
    #         return "x"
    #       end
    #     end 
    #   end
    #   return "Done"
    # else
    #   if self.phase != nil
    #       if !child.phase.status
    #         return "x"
    #       end
    #     end 
    # end
    # return "missed"
  end

  def statusInParens
    if self.status
      return "(Done)"
    else
      return ""
    end
  end

end
