json.array!(@roles) do |role|
  json.extract! role, :id, :name, :view_product, :edit_nodes, :prioritize, :manage_issues, :manage_phases
  json.url role_url(role, format: :json)
end
