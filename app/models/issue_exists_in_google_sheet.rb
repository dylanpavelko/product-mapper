class IssueExistsInGoogleSheet < ActiveRecord::Base
  belongs_to :native_issue
  belongs_to :google_sheet
end
