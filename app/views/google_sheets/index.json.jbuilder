json.array!(@google_sheets) do |google_sheet|
  json.extract! google_sheet, :id, :key
  json.url google_sheet_url(google_sheet, format: :json)
end
