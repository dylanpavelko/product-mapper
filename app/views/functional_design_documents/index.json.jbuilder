json.array!(@functional_design_documents) do |functional_design_document|
  json.extract! functional_design_document, :id, :name, :url
  json.url functional_design_document_url(functional_design_document, format: :json)
end
