require 'rails_helper'

RSpec.describe HospitalsController, type: :controller do
  let(:valid_attributes) {
    { name: 'Test Hospital', address: '123 Test Street', creation_date: Date.today - 5.years }
  }

  let(:invalid_attributes) {
    { name: nil, address: nil, creation_date: nil }
  }

  let(:user) { create :user }

  before do
    sign_in user
  end

  describe "GET #index" do
    it "returns a success response" do
      hospital = Hospital.create! valid_attributes
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      hospital = Hospital.create! valid_attributes
      get :show, params: { id: hospital.to_param }
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      hospital = Hospital.create! valid_attributes
      get :edit, params: { id: hospital.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new Hospital" do
        expect {
          post :create, params: { hospital: valid_attributes }
        }.to change(Hospital, :count).by(1)
      end

      it "redirects to the created hospital" do
        post :create, params: { hospital: valid_attributes }
        expect(response).to redirect_to(Hospital.last)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Hospital" do
        expect {
          post :create, params: { hospital: invalid_attributes }
        }.to change(Hospital, :count).by(0)
      end

      it "renders the 'new' template" do
        post :create, params: { hospital: invalid_attributes }
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PUT #update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { name: 'Updated Test Hospital', address: '456 Updated Test Street', creation_date: Date.today - 3.years }
      }

      it "updates the requested hospital" do
        hospital = Hospital.create! valid_attributes
        put :update, params: { id: hospital.to_param, hospital: new_attributes }
        hospital.reload
        expect(hospital.name).to eq('Updated Test Hospital')
        expect(hospital.address).to eq('456 Updated Test Street')
        expect(hospital.creation_date).to eq(Date.today - 3.years)
      end

      it "redirects to the hospital" do
        hospital = Hospital.create! valid_attributes
        put :update, params: { id: hospital.to_param, hospital: new_attributes }
        hospital.reload
        expect(response).to redirect_to(hospital)
      end
    end

    context "with invalid parameters" do
      it "renders the 'edit' template" do
        hospital = Hospital.create! valid_attributes
        put :update, params: { id: hospital.to_param, hospital: invalid_attributes }
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested hospital" do
      hospital = Hospital.create! valid_attributes
      expect {
        delete :destroy, params: { id: hospital.to_param }
      }.to change(Hospital, :count).by(-1)
    end

    it "redirects to the hospitals list" do
      hospital = Hospital.create! valid_attributes
      delete :destroy, params: { id: hospital.to_param }
      expect(response).to redirect_to(hospitals_url)
    end
  end
end
