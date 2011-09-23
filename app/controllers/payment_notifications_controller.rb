class PaymentNotificationsController < ApplicationController
  protect_from_forgery :except => [:create]
  
  def create
    PaymentNotification.create!(
      :params => params, 
      :cart_id => params[:invoice], 
      :status => params[:payment_status], 
      :transaction_id => params[:txn_id]
    )
    
    if params[:payment_status]=="Completed"
      @order = Order.find_by_cart_id params[:invoice].to_i
      @order.update_attributes!(
        :first_name => params[:first_name],
        :last_name => params[:last_name],
        :del_name => params[:address_name],
        :del_street => params[:address_street],
        :del_city => params[:address_city],
        :del_state => params[:address_state],
        :del_post => params[:address_zip],
        :del_country => params[:address_country],
        :status => params[:payment_status],
        :transaction_id => params[:txn_id],
        :total => params[:payment_gross].to_f,
        :payment_type => "Paypal"
      )
    end
    
    render :nothing => true
  end
end