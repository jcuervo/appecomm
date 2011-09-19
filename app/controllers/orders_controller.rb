class OrdersController < ApplicationController
  def new
    @order = Order.new()
  end
  
  def create
    @order = current_cart.build_order(params[:order])
    @order.ip_address = request.remote_ip
    if @order.save
      current_cart.line_items.each do |x|
        saveOrderItem = @order.order_items.create(
          :product_id => x.product_id,
          :quantity => x.quantity,
          :price => x.price
        )
      end
      PostOffice.order_email(@order , "" , "bchan@rivereo.com", "subject is order summary").deliver
      if @order.purchase
        render :action  => "success"
      else
        render :action => "failure"
      end
    else
      # logger.info @order.errors.full_messages
      render :action => 'new'
    end
  end
  
  def success
  end
  
  def failure
  end
end
