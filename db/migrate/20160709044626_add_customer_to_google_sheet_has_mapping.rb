class AddCustomerToGoogleSheetHasMapping < ActiveRecord::Migration
  def change
    add_reference :google_sheet_has_mappings, :customer, index: true
  end
end
