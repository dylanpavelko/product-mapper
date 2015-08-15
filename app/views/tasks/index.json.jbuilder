json.array!(@tasks) do |task|
  json.extract! task, :id, :name, :phase, :forNode, :requiredForRelease
  json.url task_url(task, format: :json)
end
