json.array!(@meetings) do |meeting|
  json.extract! meeting, :id, :name, :date
  json.url meeting_url(meeting, format: :json)
end
