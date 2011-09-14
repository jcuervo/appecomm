class LineItemsController < ApplicationController
  before_filter :load_current_cart
  
  def create
    product = Product.find(params[:line_item][:product_id])
    @line_item = @cart.add_product(product.id, product.price, params[:line_item][:quantity])
    respond_to do |format|
      if @line_item.save
        format.html { redirect_to cart_path, notice: 'Line item was successfully created.' }
        format.json { render json: cart_path, status: :created, location: @line_item }
      else
        format.html { render action: "new" }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    @line_item = @cart.line_items.find(params[:id])
    respond_to do |format|
      if @line_item.update_attributes(params[:line_item])
        format.html { redirect_to cart_path, notice: 'Line item was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @line_item = @cart.line_items.find(params[:id])
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to cart_path }
      format.json { head :ok }
    end
  end
  
  private
    def load_current_cart
      @cart = current_cart
    end
end
