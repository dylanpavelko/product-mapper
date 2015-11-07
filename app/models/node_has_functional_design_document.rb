class NodeHasFunctionalDesignDocument < ActiveRecord::Base
  belongs_to :node
  belongs_to :FDD, class_name: "FunctionalDesignDocument", foreign_key: "FDD_id"
end
