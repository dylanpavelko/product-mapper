json.array!(@user_has_favorite_nodes) do |user_has_favorite_node|
  json.extract! user_has_favorite_node, :id, :user_id, :node_id
  json.url user_has_favorite_node_url(user_has_favorite_node, format: :json)
end
