class AddMarkerToNodeType < ActiveRecord::Migration
  def change
    add_column :node_types, :marker, :boolean
  end
end
