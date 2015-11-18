class OrderItemsController < ApplicationController
def create
  #session.clear
    #@order = current_order
     if !session[:order_id].nil?
     	puts "order in session"
      @order = Order.find(session[:order_id])
    else
    	puts "no order in session"
      @order = Order.new
      @order.save
    end
   # @order.save
    @order_item = OrderItem.new(order_item_params)
    @order.order_items << @order_item
   # @order_item = @order.order_items.new(order_item_params)
    #puts  @order_item.quantity
    #puts  @order.order_items[1].quantity
    @order.save
    puts "order saved"
    session[:order_id] = @order.id
  end

  def update
    puts "update function begin"
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    puts "orderItemParams"
    puts params[:id]
    puts params[:quantity]

    @order_item.update_attributes(order_item_params)
    @order_items = @order.order_items
  end

  def destroy
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy
    @order_items = @order.order_items
  end
private
  def order_item_params
    params.require(:order_item).permit(:quantity, :product_id)
  end
end
