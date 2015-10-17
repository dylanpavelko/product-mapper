class PhaseTypeDefaultHasPhaseType < ActiveRecord::Base
  belongs_to :phase_type_default
  belongs_to :phase_type
end
