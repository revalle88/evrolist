class CartsController < ApplicationController
  def show
    @order_items = current_order.order_items

	@rootCats = Category.where(parent_id: nil)
    @categories = Category.all

    render layout: "catalog"
  end
end
