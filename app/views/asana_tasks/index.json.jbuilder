json.array!(@asana_tasks) do |asana_task|
  json.extract! asana_task, :id, :name, :asana_id, :asana_workspace_id
  json.url asana_task_url(asana_task, format: :json)
end
