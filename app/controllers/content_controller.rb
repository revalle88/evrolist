class ContentController < ApplicationController
  layout 'catalog'

def home
    @rootCats = Category.where(parent_id: nil)
    @categories = Category.all
    @news = Article.where(isNew: true).limit(2)
    @reviews = Article.where(isReview: true).limit(2)
    @article = Article.where(onHomePage: true).first
    @weekChoices = Article.where(isReview: true).limit(3)
    
end
  
  def news
  	@rootCats = Category.where(parent_id: nil)
    @categories = Category.all
    @news = Article.where(isNew: true)
  end

  def show
    @order_item = current_order.order_items.new
  	@rootCats = Category.where(parent_id: nil)
    @categories = Category.all
    @article = Article.find(params[:id])
    @articleProducts = ArticleProduct.where(article_id: params[:id])
  end
end
