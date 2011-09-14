class Page < ActiveRecord::Base
  validates :title, :content, :presence => true
  
  def to_param
    self.browser_title.blank? ? "#{self.title.parameterize}" : "#{self.browser_title.parameterize}"
  end
  
end
