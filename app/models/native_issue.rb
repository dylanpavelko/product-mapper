class NativeIssue < ActiveRecord::Base
  belongs_to :issue_with, class_name: "Node", foreign_key: "issue_with_id"
  belongs_to :resolved_with, class_name: "Node", foreign_key: "resolved_with_id"
  belongs_to :added_by, class_name: "User", foreign_key: "added_by_id"

  attr_accessor :asana_id
  attr_accessor :asana_url
  attr_accessor :asana_workspace_id
  attr_accessor :asana_name

  validates :added_by, :presence => true
end
