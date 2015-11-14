class AddDevStatusToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :dev_status, :integer
  end
end
