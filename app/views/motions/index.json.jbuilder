json.array!(@motions) do |motion|
  json.extract! motion, :id, :motion_type, :subject, :content
  json.url motion_url(motion, format: :json)
end
