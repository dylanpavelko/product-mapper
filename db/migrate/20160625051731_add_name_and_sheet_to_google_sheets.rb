class AddNameAndSheetToGoogleSheets < ActiveRecord::Migration
  def change
    add_column :google_sheets, :name, :string
    add_column :google_sheets, :sheet, :integer
  end
end
