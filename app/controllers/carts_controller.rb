class CartsController < ApplicationController
  before_filter :load_current_cart
  
  def show
    respond_to do |format|
      format.html
      format.json { render json: @cart }
    end
  end
  
  def destroy
    @cart.destroy
    session[:cart_id] = nil
    respond_to do |format|
      format.html {redirect_to root_url, :notice => "Your cart is now empty."}
      format.xml {head :ok}
    end
  end
  
  def checkout
    
  end
  
  private
    def load_current_cart
      @cart = current_cart
    end
end
