class CreateGoogleSheetHasMappings < ActiveRecord::Migration
  def change
    create_table :google_sheet_has_mappings do |t|
      t.string :column_name
      t.integer :column_number
      t.integer :data_type
      t.references :google_sheet, index: true

      t.timestamps
    end
  end
end
