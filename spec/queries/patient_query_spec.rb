require 'rails_helper'

RSpec.describe PatientQuery do
  describe "#call" do
    let!(:patient1) { create(:patient, full_name: 'John Doe', patient_card: create(:patient_card, card_number: '1234')) }
    let!(:patient2) { create(:patient, full_name: 'Jane Doe', patient_card: create(:patient_card, card_number: '5678')) }

    context "when search query is provided" do
      it "returns patients that match the query" do
        params = { query: 'John' }
        query = PatientQuery.new(Patient.all, params)

        expect(query.call).to include(patient1)
        expect(query.call).not_to include(patient2)
      end
    end

    context "when card number query is provided" do
      it "returns patients that match the card number query" do
        params = { card_number: '1234' }
        query = PatientQuery.new(Patient.all, params)

        expect(query.call).to include(patient1)
        expect(query.call).not_to include(patient2)
      end
    end

    context "when sort by card number is provided" do
      it "returns patients sorted by card number" do
        params = { sort: 'card_number' }
        query = PatientQuery.new(Patient.all, params)

        expect(query.call.first).to eq(patient1)
        expect(query.call.last).to eq(patient2)
      end
    end
  end
end
