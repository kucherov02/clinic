FactoryBot.define do
  factory :hospital do
    name { Faker::Company.name }
    address { Faker::Address.street_address }
    creation_date { Faker::Date.between(from: 50.years.ago, to: Date.today) }
  end
end
