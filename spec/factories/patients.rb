FactoryBot.define do
  factory :patient do
    full_name { "John Doe" }
    date_of_birth { 30.years.ago }
    association :patient_card
  end
end
