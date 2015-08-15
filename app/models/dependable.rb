class Dependable < ActiveRecord::Base
	belongs_to :phase, class_name: "Phase", foreign_key: "phase_id"
	belongs_to :task, class_name: "Task", foreign_key: "task_id"
	belongs_to :question, class_name: "Question", foreign_key: "question_id"

	def name
    	name = "Phase " + phase.name
  	end
end
