json.array!(@products) do |product|
  json.extract! product, :id, :name, :id1c, :descriptionFull, :descriptionMin, :articul, :baseUnit, :shtrihkod, :standart, :price, :rest, :category_id
  json.url product_url(product, format: :json)
end
