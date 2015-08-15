class NewDepenableTable < ActiveRecord::Migration
  def change
  	  create_table :dependables do |t|
  	  	t.references :node, index: true
  		t.references :phase, index: true
  		t.references :task, index: true
  		t.references :dependentNode, index: true
  		t.references :dependentPhase, index: true
  		t.references :dependentTask, index: true
      	t.timestamps
       end
  	end
end
