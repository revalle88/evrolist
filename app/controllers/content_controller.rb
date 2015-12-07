class ContentController < ApplicationController
  layout 'catalog'

def home
    @rootCats = Category.where(parent_id: nil)
    @categories = Category.all
    @news = Article.where(isNew: true).limit(2)
    @reviews = Article.where(isReview: true).limit(2)
    @article = Article.where(onHomePage: true).first

end
  
  def news
  	@rootCats = Category.where(parent_id: nil)
    @categories = Category.all
    @news = Article.where(isNew: true)
  end

  def show
  	@rootCats = Category.where(parent_id: nil)
    @categories = Category.all
    @article = Article.find(params[:id])
  end
end
