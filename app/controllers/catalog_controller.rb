class CatalogController < ApplicationController
  def root
  	@rootCats = Category.where(parent_id: nil)
    @categories = Category.all
   
    #@products = Product.search(params[:search])
    #@products = Product.all
    ##cart
    @order_item = current_order.order_items.new
    
  end
  def show
  	@rootCats = Category.where(parent_id: nil)
    @categories = Category.all
    @cat = Category.find(params[:cat_id])
  	@catProducts = Product.where(category_id: params[:cat_id]).page(params[:page]).per_page(12)
  	puts "sjldkfjdlkf"
  	puts params[:cat_id]
    ##cart
    @order_item = current_order.order_items.new

  end

  def product
    @rootCats = Category.where(parent_id: nil)
    @categories = Category.all
    @product = Product.find(params[:good_id])

  end 
    def addProp
    prop = Property.find(1)
    product = Product.find(1)
    product.productProperties.create(property: prop, stringValue: "свойство1")
    @properties = Property.all
    @products = Product.all

  end

  def search
    @rootCats = Category.where(parent_id: nil)
    @categories = Category.all
    @catProducts = Product.search(params[:search]).page(params[:page]).per_page(12)
    @order_item = current_order.order_items.new
    @order_item = current_order.order_items.new
  end
  
end
