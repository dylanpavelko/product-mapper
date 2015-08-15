class AddDependenciesToNodeAndTasks < ActiveRecord::Migration
  def change
  	add_reference :nodes, :dependsOnNodes, index: true
  	add_reference :nodes, :dependsOnTasks, index: true
  	add_reference :tasks, :dependsOnNodes, index: true
  	add_reference :tasks, :dependsOnTasks, index: true
  end
end
