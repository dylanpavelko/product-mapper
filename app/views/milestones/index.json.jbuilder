json.array!(@milestones) do |milestone|
  json.extract! milestone, :id, :name, :date, :major_release
  json.url milestone_url(milestone, format: :json)
end
