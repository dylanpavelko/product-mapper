class NodeHistory < ActiveRecord::Base
  belongs_to :node
  belongs_to :user
  belongs_to :other_node, class_name: 'Node', foreign_key: "other_node_id"
  belongs_to :other_reference
end
