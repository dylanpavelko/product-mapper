class AddOrganizationToNodes < ActiveRecord::Migration
  def change
    add_reference :nodes, :organization, index: true
  end
end
