module ContentHelper

  def weekChoiceMinPrice(wc)
  	@articleProducts = ArticleProduct.where(article_id: wc.id)
    @articlePrices = []
  	@articleProducts.each do |ap|

  	   
  		    @articlePrices.push(ap.product.price)

  	  
  	end
  	@articlePrices.min
  end
end
