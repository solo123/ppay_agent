json.array!(@companies) do |company|
  json.extract! company, :id, :name, :short_name
  json.url company_url(company, format: :json)
end
