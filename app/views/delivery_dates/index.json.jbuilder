json.array!(@delivery_dates) do |delivery_date|
  json.extract! delivery_date, :id, :node_id, :target_type, :envrionment_id, :milestone_id, :date
  json.url delivery_date_url(delivery_date, format: :json)
end
