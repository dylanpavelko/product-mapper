class AsanaWorkspace < ActiveRecord::Base
  belongs_to :node
  belongs_to :added_by, class_name: 'User', foreign_key: "added_by_id"
end
