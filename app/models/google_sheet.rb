class GoogleSheet < ActiveRecord::Base

	require "google_drive"

	def get_sheet
		session = GoogleDrive.saved_session("google_app_config.json")

		ws = session.spreadsheet_by_key(self.key).worksheets[self.sheet]
	end

	def get_sheet_rows
		session = GoogleDrive.saved_session("google_app_config.json")

		ws = session.spreadsheet_by_key(self.key).worksheets[self.sheet]

		return ws.rows
	end


end
