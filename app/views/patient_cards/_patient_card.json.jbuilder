json.extract! patient_card, :id, :card_number, :created_at, :updated_at
json.url patient_card_url(patient_card, format: :json)
