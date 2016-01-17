class AsanaWorkspace < ActiveRecord::Base
  belongs_to :node
  belongs_to :added_by, class_name: 'User', foreign_key: "added_by_id"
  belongs_to :asana_auth_endpoint, class_name: "AsanaAuthEndPoint", foreign_key: "auth_endpoint_id"
end
