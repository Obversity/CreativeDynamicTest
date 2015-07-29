json.array!(@products) do |product|
  json.extract! product, :id, :product_id, :category, :product_name, :price
  json.url product_url(product, format: :json)
end
