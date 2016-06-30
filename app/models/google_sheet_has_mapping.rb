class GoogleSheetHasMapping < ActiveRecord::Base
  belongs_to :google_sheet


  def mapping

  	if self.data_type == 1
  		return "External ID"
  	elsif self.data_type == 2
  		return "Native Issue Summary"
  	elsif self.data_type == 3
  		return "Native Issue Description"
  	elsif self.data_type == 4
  		return "Native Issue Type"
  	elsif self.data_type == 5
  		return "Opened By"
  	elsif self.data_type == 6
  		return "Date Added"
  	elsif self.data_type == 7
  		return "Comments"
  	end
  end


  def difference(native_issue, imported_value)
  	if self.data_type==2
  		if native_issue.summary == imported_value
  			return nil
  		elsif native_issue.summary != ""
  			return "Discrepency"
  		end
  	elsif self.data_type==3
   		if native_issue.description == imported_value
  			return nil
  		elsif native_issue.description != ""
  			return "Discrepency"
  		end 		
  	elsif self.data_type==4
      if (imported_value.downcase.include? "enhancement") != native_issue.enhancement
        return "Discrepency"
      end
    elsif self.data_type==5
      if imported_value != native_issue.added_by.display_name
        return "Discrepency"
      end
    end
  	return nil
  end

end
