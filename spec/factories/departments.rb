FactoryBot.define do
  factory :department do
    name { 'Cardiology' }
    number { 1 }
    creation_date { Date.today - 1.year }
    hospital
  end
end
