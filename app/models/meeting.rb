class Meeting < ActiveRecord::Base
    
  def display
      return self.name + " - " + self.date.strftime("%m/%d/%Y")
  end
  
end
