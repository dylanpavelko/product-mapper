json.array!(@phases) do |phase|
  json.extract! phase, :id, :phaseType, :completionStatus
  json.url phase_url(phase, format: :json)
end
