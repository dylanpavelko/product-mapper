class AddRowOrderToNode < ActiveRecord::Migration
  def change
    add_column :nodes, :row_order, :integer
  end
end
