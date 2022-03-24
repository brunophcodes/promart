class OrderItemsController < ApplicationController

  def create
    # Find associated product and current cart
    chosen_product = Product.find(params[:product_id])
    # current_cart = @current_cart
    add_items_to_cart(chosen_product)
    # If cart already has this product then find the relevant order_item and iterate quantity otherwise create a new order_item for this product
    # Save and redirect to cart show path
    @order_item.save!
    redirect_to cart_path
  end

  def destroy
    @order_item = OrderItem.find(params[:id])
    @order_item.destroy
    redirect_to cart_path
  end

  def add_quantity
    @order_item = OrderItem.find(params[:id])
    @order_item.quantity += 1
    @order_item.save
    redirect_to cart_path
  end

  def reduce_quantity
    @order_item = OrderItem.find(params[:id])
    if @order_item.quantity > 1
      @order_item.quantity -= 1
    else
      @order_item.destroy
    end
    @order_item.save
    redirect_to cart_path
  end

  private
    def order_item_params
      params.require(:order_item).permit(:quantity, :product_id, :cart_id)
    end

    def add_items_to_cart(chosen_product)
      # If cart already has this product then find the relevant line_item
      # and iterate quantity otherwise create a new line_item for this product
      if @current_cart.products.include?(chosen_product)
        # Find the line_item with the chosen_product
        @order_item = @current_cart.order_items.find_by(product_id: chosen_product)
        # Iterate the order_item's quantity by one
        @order_item.quantity += 1
      else
        @order_item = OrderItem.new
        @order_item.cart = @current_cart
        @order_item.product= chosen_product
        # @order_item.order_id = @orden.id
        @order_item.quantity = 1
      end
    end
end
