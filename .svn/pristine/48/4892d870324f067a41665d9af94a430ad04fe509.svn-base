class Phase < ActiveRecord::Base
	belongs_to :phaseType, class_name: "PhaseType", foreign_key: "phaseType_id"
	belongs_to :node, class_name: "Node", foreign_key: "node_id"
	has_many :dependencies, class_name: "Dependable", foreign_key: "dependencies_id"

	def name
      displayName = node.name + " ["+ phaseType.name + "]" 
    end

    def type
    	displayName = phaseType.name
    end
end
