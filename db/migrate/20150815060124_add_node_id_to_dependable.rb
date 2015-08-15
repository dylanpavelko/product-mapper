class AddNodeIdToDependable < ActiveRecord::Migration
  def change
  	add_reference :dependables, :node_id, index: true
  end
end
