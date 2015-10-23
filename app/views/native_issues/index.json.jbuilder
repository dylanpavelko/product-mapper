json.array!(@native_issues) do |native_issue|
  json.extract! native_issue, :id, :summary, :description, :enhancement, :issue_with_id, :resolved_with_id, :close_without_resolution
  json.url native_issue_url(native_issue, format: :json)
end
