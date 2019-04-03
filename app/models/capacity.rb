class Capacity < ActiveRecord::Base
  belongs_to :team
  belongs_to :milestone
  
  @remaining_capacity = 0
  
  def initialize_remaining_capacity()
    @remaining_capacity = self.amount
  end
    
  def decrease_capacity(amount)
    @remaining_capacity = @remaining_capacity - amount
    return @remaining_capacity
  end
  
  def get_remaining_capacity
    return @remaining_capacity
  end

end
