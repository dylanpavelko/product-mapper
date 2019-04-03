class Effort < ActiveRecord::Base
  belongs_to :team
  belongs_to :node, class_name: "Node", foreign_key: "node_id"
end
