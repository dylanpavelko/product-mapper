class NativeIssueHasResponse < ActiveRecord::Base
  belongs_to :native_issue
  belongs_to :response
end
