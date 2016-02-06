class NodeHasTheme < ActiveRecord::Base
  belongs_to :node
  belongs_to :theme
end
