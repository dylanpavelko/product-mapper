class DropPhaseComponentsTableAndExtraIdColumns < ActiveRecord::Migration
  def change
  	drop_table :phase_components
  	remove_column :nodes, :questions_id
  	remove_column :questions, :dependencies_id
  end
end
