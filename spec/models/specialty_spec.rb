require 'rails_helper'

RSpec.describe Specialty, type: :model do
  describe 'validations' do
    it 'is invalid without a name' do
      specialty = Specialty.new
      expect(specialty).not_to be_valid
    end

    it 'is valid with a name' do
      specialty = Specialty.new(name: 'Specialty')
      expect(specialty).to be_valid
    end
  end
end
