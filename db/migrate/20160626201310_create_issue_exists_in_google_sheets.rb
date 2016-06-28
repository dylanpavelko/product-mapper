class CreateIssueExistsInGoogleSheets < ActiveRecord::Migration
  def change
    create_table :issue_exists_in_google_sheets do |t|
      t.references :native_issue, index: true
      t.references :google_sheet, index: true
      t.integer :external_id

      t.timestamps
    end
  end
end
