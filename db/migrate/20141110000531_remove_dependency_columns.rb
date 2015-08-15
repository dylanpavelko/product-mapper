class RemoveDependencyColumns < ActiveRecord::Migration
  def change
	remove_reference :nodes, :dependsOnNodes, index: true
  	remove_reference :nodes, :dependsOnTasks, index: true
  	remove_reference :tasks, :dependsOnNodes, index: true
  	remove_reference :tasks, :dependsOnTasks, index: true
  end
end
