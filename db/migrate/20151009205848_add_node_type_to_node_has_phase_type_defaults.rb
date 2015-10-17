class AddNodeTypeToNodeHasPhaseTypeDefaults < ActiveRecord::Migration
  def change
    add_reference :node_has_phase_type_defaults, :node_type, index: true
  end
end
