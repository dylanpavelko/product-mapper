json.array!(@issue_exists_in_google_sheets) do |issue_exists_in_google_sheet|
  json.extract! issue_exists_in_google_sheet, :id, :native_issue_id, :google_sheet_id, :external_id
  json.url issue_exists_in_google_sheet_url(issue_exists_in_google_sheet, format: :json)
end
