class CreateQuestions < ActiveRecord::Migration
  def change
  	add_reference :questions, :node_id, index: true
  	add_reference :questions, :phase_id, index: true
  end
end
