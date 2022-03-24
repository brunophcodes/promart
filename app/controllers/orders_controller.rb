class OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
    @cart = @current_cart
  end

  def create
    @order = Order.new(order_params)
    @order.update(user_id: current_user.id)
    add_items_to_order

    @order.save
    reset_sessions_cart
    redirect_to root_path
  end


private

  def add_items_to_order
    @current_cart.order_items.each do |item|
      # item.cart_id = nil
      item.order_id = @order.id
      item.save
      @order.order_items << item

    end
  end

  def reset_sessions_cart
    Cart.destroy(session[:cart_id])
    session[:cart_id] = nil
  end

  def order_params
    params.require(:order).permit(:comment, :user_id)
  end
end
