class Task < ActiveRecord::Base
	belongs_to :phase, class_name: "Phase", foreign_key: "phase_id"
	has_many :questions, class_name: "Question", foreign_key: "question_id"
end
