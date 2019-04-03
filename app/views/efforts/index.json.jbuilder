json.array!(@efforts) do |effort|
  json.extract! effort, :id, :amount, :team_id, :node_id
  json.url effort_url(effort, format: :json)
end
