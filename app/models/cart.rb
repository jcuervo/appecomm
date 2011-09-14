class Cart < ActiveRecord::Base
  has_many :line_items, :dependent => :destroy
  
  def add_product(product_id, price, quantity)
    current_item = line_items.find_by_product_id(product_id)
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(:product_id => product_id, :price => price, :quantity => quantity)
    end
    current_item
  end
  
  def total_items
    (self.line_items.size > 0) ? self.line_items.all.inject(0) {|sum, item| sum + item.quantity} : 0
  end
  
  def total_price
    (self.line_items.size > 0) ? self.line_items.all.inject(0) {|sum, item| sum + (item.price * item.quantity)} : 0
  end
end
