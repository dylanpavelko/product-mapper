json.array!(@google_sheet_has_mappings) do |google_sheet_has_mapping|
  json.extract! google_sheet_has_mapping, :id, :column_name, :column_number, :data_type, :google_sheet_id
  json.url google_sheet_has_mapping_url(google_sheet_has_mapping, format: :json)
end
