class AddQuestionColumns < ActiveRecord::Migration
  def change
  	add_reference :nodes, :questions, index: true
  	add_reference :tasks, :questions, index: true
  end
end
