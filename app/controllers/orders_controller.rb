class OrdersController < ApplicationController
  protect_from_forgery :except => [:notify]
  
  def new
    @order = Order.new()
  end
  
  def create
    @order = current_cart.build_order(params[:order])
    @order.ip_address = request.remote_ip
    @order.payment_type = "CreditCard"
    if @order.save
      create_order_items
      # PostOffice.order_email(@order , "" , "bchan@rivereo.com", "subject is order summary").deliver

      if @order.purchase
        @order.update_attributes!(:status => 'Completed')
        current_cart.destroy
        session[:cart_id] = nil
        render :action  => "success"
      else
        render :action => "failure"
      end
    else
      render :action => 'new'
    end
  end
  
  def success
    # clear session
  end
  
  def failure
    @order = Order.last
  end
  
  def thankyou
    current_cart.destroy
  end
  
  def paypal_process
    @order = Order.create!(:cart_id => current_cart.id)
    create_order_items
    redirect_to current_cart.paypal_url(thankyou_orders_url, "http://beta.rivereo.com")
  end
  
  
  private
  
  def create_order_items
    current_cart.line_items.each do |x|
      saveOrderItem = @order.order_items.create(
        :product_id => x.product_id,
        :quantity => x.quantity,
        :price => x.price
      )
    end
  end
  
end
