class OrdersController < ApplicationController
  layout 'admin'
  before_filter :verify_is_admin
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

  private

def verify_is_admin
  (current_user.nil?) ? redirect_to(new_user_session_path) : (redirect_to(new_user_session_path) unless current_user.admin?)
end


end