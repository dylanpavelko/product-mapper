json.array!(@node_histories) do |node_history|
  json.extract! node_history, :id, :node_id, :user_id, :log, :type, :other_node_id, :other_reference_id
  json.url node_history_url(node_history, format: :json)
end
