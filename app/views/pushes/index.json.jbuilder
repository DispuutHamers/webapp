json.array!(@pushes) do |push|
  json.extract! push, :id, :user_id, :data
  json.url push_url(push, format: :json)
end
