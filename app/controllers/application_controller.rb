class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :load_cart
    
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to "/", :alert => exception.message
  end
  
  protected
    def load_cart
      @current_cart = current_cart
    end
  
  private
    def current_cart
      # Cart.find(session[:cart_id])
      cart ||= Cart.find(session[:cart_id])
      session[:cart_id] = nil if cart.purchased_at
      cart
    rescue ActiveRecord::RecordNotFound
      cart = Cart.create
      session[:cart_id] = cart.id
      cart
    end
end
