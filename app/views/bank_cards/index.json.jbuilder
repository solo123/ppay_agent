json.array!(@bank_cards) do |bank_card|
  json.extract! bank_card, :id, :bank_name, :bank_sub_branch, :account_name, :account_number
  json.url bank_card_url(bank_card, format: :json)
end
