class CheckoutController < ApplicationController
  layout 'catalog'
  def checkout_form
   @rootCats = Category.where(parent_id: nil)
    @categories = Category.all
  end
  def savedetails
@rootCats = Category.where(parent_id: nil)
    @categories = Category.all
  	
  	order = Order.find(params[:order_id])
  	order.name = params[:name]
  	order.surname = params[:surname]
  	order.email = params[:email]
  	order.save
  	@order = order
  #	render "checkout_form"

  end
end
