class NodeHistory < ActiveRecord::Base
  belongs_to :node
  belongs_to :user
  belongs_to :other_node
  belongs_to :other_reference
end
