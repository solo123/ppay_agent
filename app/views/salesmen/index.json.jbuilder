json.array!(@object) do |obj|
  json.extract! obj, :id, :name
  json.url salesmen_path(obj, format: :json)
end
