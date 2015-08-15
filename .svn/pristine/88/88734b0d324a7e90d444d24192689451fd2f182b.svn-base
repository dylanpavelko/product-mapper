class QuestionsColumns < ActiveRecord::Migration
  def change
  	  	remove_reference :questions, :node_id, index: true
  		remove_reference :questions, :phase_id, index: true
  		add_reference :questions, :node, index: true
  		add_reference :questions, :phase, index: true
  end
end

