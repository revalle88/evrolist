class ContentController < ApplicationController
  layout 'catalog'
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
