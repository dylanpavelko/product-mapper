json.array!(@asana_workspaces) do |asana_workspace|
  json.extract! asana_workspace, :id, :workspace, :node_id, :added_by_id
  json.url asana_workspace_url(asana_workspace, format: :json)
end
