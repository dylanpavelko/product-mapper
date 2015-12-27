class FunctionalDesignDocument < ActiveRecord::Base
	validates :name, :presence => true
	validates :url, :presence => true

  def matches(search_string)
    @search_pieces = search_string.split(' ')
    @search_pieces.each do |word|
      if !self.name.downcase.include? word.downcase
        return false
      end
    end
    return true
  end
end
