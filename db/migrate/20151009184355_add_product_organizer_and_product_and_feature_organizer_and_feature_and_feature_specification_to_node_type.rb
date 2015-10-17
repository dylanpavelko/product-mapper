class AddProductOrganizerAndProductAndFeatureOrganizerAndFeatureAndFeatureSpecificationToNodeType < ActiveRecord::Migration
  def change
    add_column :node_types, :product_organizer, :boolean
    add_column :node_types, :product, :boolean
    add_column :node_types, :feature_organizer, :boolean
    add_column :node_types, :feature, :boolean
    add_column :node_types, :specification, :boolean
  end
end
