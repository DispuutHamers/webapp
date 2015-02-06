json.array!(@news) do |news|
  json.extract! news, :id, :cat, :body, :title, :image, :date
  json.url news_url(news, format: :json)
end
