class AddDependencyColumns < ActiveRecord::Migration
  def change
  	add_reference :phases, :dependencies, index: true
  	add_reference :tasks, :dependencies, index: true
  	add_reference :questions, :dependencies, index: true
  end
end
