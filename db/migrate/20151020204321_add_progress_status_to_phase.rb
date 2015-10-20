class AddProgressStatusToPhase < ActiveRecord::Migration
  def change
  	add_column :phases, :progress_status, :integer

    Phase.reset_column_information 

    phases = Phase.all

    phases.each do |p|
    	if p.status
    		p.progress_status = 1
    	else
    		p.progress_status = 0
    	end
      p.save!
    end
  end
end
