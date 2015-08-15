class AddNodeIdToDependable < ActiveRecord::Migration
  def change
  	add_column :dependables, :node_id, :reference
  end
end
