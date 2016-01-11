class AddAsanaAuthEndPointToAsanaWorkspaces < ActiveRecord::Migration
  def change
    add_reference :asana_workspaces, :auth_endpoint, index: true
  end
end
