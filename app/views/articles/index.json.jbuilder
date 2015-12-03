json.array!(@articles) do |article|
  json.extract! article, :id, :title, :content, :description, :isNew, :isReview, :onHomePage
  json.url article_url(article, format: :json)
end
