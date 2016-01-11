class AsanaWorkspace < ActiveRecord::Base
  belongs_to :node
  belongs_to :added_by
end
