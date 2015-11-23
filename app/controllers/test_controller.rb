class TestController < ApplicationController
  def createorder
  	    #@order = current_order
     if !session[:order_id].nil?
     	puts "order in session"
      @order = Order.find(session[:order_id])
    else
    	puts "no order in session"
      @order = Order.new
    end

OrderItem.create(order_id: @order.id, product_id: 66, quantity: 10)

    #@order_item = OrderItem.new
    #@order_item.quantity = 3

   # @order.order_items << @order_item
    #@order_item = @order.order_items.new(quantity: 3)

   # @order_item = @order.order_items.new(order_item_params)
    #puts  @order_item.quantity
    #puts  @order.order_items[1].quantity
    @order.subtotal = 23.11
    @order.save
    puts "order saved"
    session[:order_id] = @order.id
  end
  def clearSession
  	session.clear
    puts "session cleared"
  end
end