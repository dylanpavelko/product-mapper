class FixCompletionStatusOnPhase < ActiveRecord::Migration
  def change
  	remove_column :phases, :completionStatus
  	add_column :phases, :status, :boolean
  end
end
