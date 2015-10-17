class Dependable < ActiveRecord::Base
	belongs_to :phase, class_name: "Phase", foreign_key: "phase_id"
	belongs_to :task, class_name: "Task", foreign_key: "task_id"
	belongs_to :question, class_name: "Question", foreign_key: "question_id"
	belongs_to :depentPhase, class_name: "Phase", foreign_key: "dependentPhase_id"

	def name
    	name = phase.name
  	end

  	def forPhase
  		return Phase.find(dependentPhase_id)
  	end
end
