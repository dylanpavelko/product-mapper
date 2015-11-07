json.array!(@node_has_functional_design_documents) do |node_has_functional_design_document|
  json.extract! node_has_functional_design_document, :id, :node_id, :FDD_id
  json.url node_has_functional_design_document_url(node_has_functional_design_document, format: :json)
end
