json.array!(@courses) do |course|
  json.extract! course, :id, :title, :professor, :time, :location
  json.url course_url(course, format: :json)
end
