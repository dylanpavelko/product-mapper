class AddDependableColumns < ActiveRecord::Migration
  def change
  	add_reference :dependables, :phase, index: true
  	add_reference :dependables, :task, index: true
  	add_reference :dependables, :question, index: true
  end
end
