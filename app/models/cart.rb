class Cart < ActiveRecord::Base
  has_many :line_items, :dependent => :destroy
  has_one :order#, :dependent => :destroy
  
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
  
  # IPN Call
  def paypal_url(return_url, notify_url)
    values = {
      :business => PAYPAL_ACCOUNT,
      :cmd => '_cart',
      :upload => 1,
      :return => return_url,
      :invoice => id,
      :notify_url => notify_url
    }
    line_items.each_with_index do |item, index|
      values.merge!({
        "amount_#{index+1}" => item.price,
        "item_name_#{index+1}" => item.product.name,
        "item_number_#{index+1}" => item.id,
        "quantity_#{index+1}" => item.quantity
      })
    end
    "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
  end
end
