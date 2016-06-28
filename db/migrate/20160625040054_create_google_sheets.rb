class CreateGoogleSheets < ActiveRecord::Migration
  def change
    create_table :google_sheets do |t|
      t.string :key

      t.timestamps
    end
  end
end
