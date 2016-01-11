json.array!(@native_issue_has_asanas) do |native_issue_has_asana|
  json.extract! native_issue_has_asana, :id, :asana_task_id, :native_issue_id
  json.url native_issue_has_asana_url(native_issue_has_asana, format: :json)
end
