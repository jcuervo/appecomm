class Product < ActiveRecord::Base
  validates :name, :price, :presence => true
  validates :price, :numericality => true
  
  has_many :line_items
  
  default_scope :order => "Name"
  
  before_destroy :ensure_not_referenced_by_any_line_item
  
  def to_param
    "#{self.id}-#{self.name.parameterize}"
  end
  
  private
    def ensure_not_referenced_by_any_line_item
      if line_items.empty?
        return true
      else
        errors.add(:base, "Line Items present")
        return false
      end
    end

end
