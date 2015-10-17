json.array!(@phase_type_default_has_phyase_types) do |phase_type_default_has_phyase_type|
  json.extract! phase_type_default_has_phyase_type, :id, :phase_type_default_id, :phase_type_id
  json.url phase_type_default_has_phyase_type_url(phase_type_default_has_phyase_type, format: :json)
end
