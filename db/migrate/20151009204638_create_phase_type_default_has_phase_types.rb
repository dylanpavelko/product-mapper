class CreatePhaseTypeDefaultHasPhaseTypes < ActiveRecord::Migration
  def change
    create_table :phase_type_def_has_phase_types do |t|
      t.references :phase_type_default, index: true
      t.references :phase_type, index: true

      t.timestamps
    end
  end
end
