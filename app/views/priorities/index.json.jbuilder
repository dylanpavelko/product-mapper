json.array!(@priorities) do |priority|
  json.extract! priority, :id, :score, :node_id
  json.url priority_url(priority, format: :json)
end
