require 'rails_helper'

RSpec.describe Hospital, type: :model do
  it 'is valid with a name, address, and creation date' do
    hospital = Hospital.new(name: 'Test Hospital', address: '123 Main St', creation_date: Date.today)
    expect(hospital).to be_valid
  end

  it 'is invalid without a name' do
    hospital = Hospital.new(address: '123 Main St', creation_date: Date.today)
    expect(hospital).not_to be_valid
  end
end
