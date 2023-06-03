json.extract! patient, :id, :full_name, :date_of_birth, :patient_card_id, :created_at, :updated_at
json.url patient_url(patient, format: :json)
