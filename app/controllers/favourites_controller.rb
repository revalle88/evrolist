class FavouritesController < ApplicationController
  def addToFavourites
		puts "AJAX AJXA AJXA AJAXA"
		if !session[:favourite_id] then
			session[:favourite_id] = []
		end
		unless session[:favourite_id].include?(params[:id])
			session[:favourite_id] << params[:id]
		end
  		#(session[:favourite_id] ||= []) << params[:id]
  		render :json => {
                            :file_content => params[:id]
                        }

  end

  def showFavourites
  	##cart
    @order_item = current_order.order_items.new
  	@rootCats = Category.where(parent_id: nil)
    @categories = Category.all
    if !session[:favourite_id].nil?
  	 sessProds = session[:favourite_id] 
  	  @Prods = []
  	   sessProds.each do |sessProd|
  		    @Prods.push(Product.find(sessProd))

  	   end
  	render layout: "catalog"
   else
    render layout: "catalog"
  end
  end

   def destroy
   	session[:favourite_id].delete(params[:id])
    redirect_to :action => "showFavourites"
    
  end

  def deleteSession
  	@rootCats = Category.where(parent_id: nil)
    @categories = Category.all
  	reset_session
  	render action: 'showFavourites'
  end
end
