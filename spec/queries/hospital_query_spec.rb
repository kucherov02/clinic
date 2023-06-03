require 'rails_helper'

RSpec.describe HospitalQuery do
  describe "#call" do
    let!(:hospital1) { create(:hospital, name: 'A Hospital') }
    let!(:hospital2) { create(:hospital, name: 'B Hospital') }

    context "when search query is provided" do
      it "returns hospitals that match the query" do
        params = { query: 'A Hospital' }
        query = HospitalQuery.new(Hospital.all, params)

        expect(query.call).to include(hospital1)
        expect(query.call).not_to include(hospital2)
      end
    end

    context "when sort by name is provided" do
      it "returns hospitals sorted by name" do
        params = { sort: 'name' }
        query = HospitalQuery.new(Hospital.all, params)

        expect(query.call.first).to eq(hospital1)
        expect(query.call.last).to eq(hospital2)
      end
    end
  end
end
