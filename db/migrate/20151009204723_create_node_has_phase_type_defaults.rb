class CreateNodeHasPhaseTypeDefaults < ActiveRecord::Migration
  def change
    create_table :node_has_phase_type_defaults do |t|
      t.references :node, index: true
      t.references :phase_type_default, index: true

      t.timestamps
    end
  end
end
