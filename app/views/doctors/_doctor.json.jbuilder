json.extract! doctor, :id, :full_name, :date_of_joining, :department_id, :created_at, :updated_at
json.url doctor_url(doctor, format: :json)
