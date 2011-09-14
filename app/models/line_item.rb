class LineItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :product
  
  def sub_total
    self.quantity * self.price
  end
end
