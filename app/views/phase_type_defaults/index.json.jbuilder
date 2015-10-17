json.array!(@phase_type_defaults) do |phase_type_default|
  json.extract! phase_type_default, :id
  json.url phase_type_default_url(phase_type_default, format: :json)
end
