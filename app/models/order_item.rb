class OrderItem < ActiveRecord::Base
  belongs_to :order
  
  def sub_total
    self.quantity * self.price
  end
end
