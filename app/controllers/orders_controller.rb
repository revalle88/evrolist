class OrdersController < ApplicationController
  layout 'admin'
	def index
    	@orders = Order.all.page(params[:page]).per_page(5)
   		
  #  @categories = Category.all
  end
  def show
  	@order = Order.find(params[:id])
  	@order_items = @order.order_items
  end
  def delete

  end

end