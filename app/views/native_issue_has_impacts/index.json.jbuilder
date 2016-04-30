json.array!(@native_issue_has_impacts) do |native_issue_has_impact|
  json.extract! native_issue_has_impact, :id, :customer_id, :native_issue_id, :impact
  json.url native_issue_has_impact_url(native_issue_has_impact, format: :json)
end
