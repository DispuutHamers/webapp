json.array!(@public_pages) do |public_page|
  json.extract! public_page, :id, :content, :title, :public
  json.url public_page_url(public_page, format: :json)
end
