json.array!(@node_has_phase_type_defaults) do |node_has_phase_type_default|
  json.extract! node_has_phase_type_default, :id, :node_id, :phase_type_default_id
  json.url node_has_phase_type_default_url(node_has_phase_type_default, format: :json)
end
