class Phase < ActiveRecord::Base
	  include PublicActivity::Common
    belongs_to :phaseType, class_name: "PhaseType", foreign_key: "phaseType_id"
	belongs_to :node, class_name: "Node", foreign_key: "node_id"

	def name
      displayName = node.name + " ["+ phaseType.name + "]" 
    end

    def type
    	displayName = phaseType.name
    end

    def get_progress_status_text
    	if self.progress_status == 1
    		return 'Done'
    	elsif self.progress_status == 2
    		return 'In Progress'
    	else
    		return 'Backlog'
    	end	
    end

    def get_progress_status(status)
        if status == 1
            return 'Done'
        elsif status == 2
            return 'In Progress'
        else
            return 'Backlog'
        end 
    end

    def dependencies
        return Dependable.where(:dependentPhase_id => self.id)
    end
end
