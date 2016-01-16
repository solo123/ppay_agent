json.array!(@notes) do |note|
  json.extract! note, :id, :tip, :note
  json.user note.user
  json.url user_url(note.user, format: :json)
end
