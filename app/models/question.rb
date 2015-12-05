class Question < ActiveRecord::Base
	belongs_to :asked_by_user, class_name: "User", foreign_key: "asked_by_user_id"
	belongs_to :node, class_name: "Node", foreign_key: "node_id"
	belongs_to :phaseType, class_name: "PhaseType", foreign_key: "phase_id"
end