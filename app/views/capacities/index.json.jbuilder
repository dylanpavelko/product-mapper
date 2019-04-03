json.array!(@capacities) do |capacity|
  json.extract! capacity, :id, :amount, :team_id, :milestone_id
  json.url capacity_url(capacity, format: :json)
end
