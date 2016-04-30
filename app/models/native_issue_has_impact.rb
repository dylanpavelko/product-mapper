class NativeIssueHasImpact < ActiveRecord::Base
  belongs_to :customer
  belongs_to :native_issue

  def impact_text
  	impact = "No Impact"
  	if self.impact == 1
  		impact = "Blocker"
  	elsif self.impact == 2
  		impact = "Critical"
  	elsif self.impact == 3
  		impact = "Nice to Have"
  	end
  	return impact
  end
end
