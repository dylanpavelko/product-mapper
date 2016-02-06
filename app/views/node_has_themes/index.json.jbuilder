json.array!(@node_has_themes) do |node_has_theme|
  json.extract! node_has_theme, :id, :node_id, :theme_id
  json.url node_has_theme_url(node_has_theme, format: :json)
end
