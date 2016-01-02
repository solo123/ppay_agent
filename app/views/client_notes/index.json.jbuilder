json.array!(@client_notes) do |client_note|
  json.extract! client_note, :id, :note, :tip
  json.url client_note_url(client_note, format: :json)
end
