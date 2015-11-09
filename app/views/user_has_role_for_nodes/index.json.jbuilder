json.array!(@user_has_role_for_nodes) do |user_has_role_for_node|
  json.extract! user_has_role_for_node, :id, :user_id, :role_id, :node_id
  json.url user_has_role_for_node_url(user_has_role_for_node, format: :json)
end
