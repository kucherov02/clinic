json.extract! hospital, :id, :name, :address, :creation_date, :created_at, :updated_at
json.url hospital_url(hospital, format: :json)
