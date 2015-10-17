class NodeHasPhaseTypeDefault < ActiveRecord::Base
  belongs_to :node
  belongs_to :phase_type_default
end
