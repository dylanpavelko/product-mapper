class CreatePhaseTypeDefaults < ActiveRecord::Migration
  def change
    create_table :phase_type_defaults do |t|

      t.timestamps
    end
  end
end
