require 'rails_helper'

RSpec.describe PatientsController, type: :controller do
  let(:valid_attributes) {
    { full_name: 'John Doe', date_of_birth: 30.years.ago, patient_card_id: create(:patient_card).id }
  }

  let(:invalid_attributes) {
    { full_name: nil, date_of_birth: nil, patient_card_id: nil }
  }

  let(:user) { create :user }  # Assumes you have a user factory and Devise installed

  before do
    sign_in user  # This will sign in the user before each test
  end

  describe "GET #index" do
    it "returns a success response" do
      patient = Patient.create! valid_attributes
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      patient = Patient.create! valid_attributes
      get :show, params: { id: patient.to_param }
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
      patient = Patient.create! valid_attributes
      get :edit, params: { id: patient.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new Patient" do
        expect {
          post :create, params: { patient: valid_attributes }
        }.to change(Patient, :count).by(1)
      end

      it "redirects to the created patient" do
        post :create, params: { patient: valid_attributes }
        expect(response).to redirect_to(Patient.last)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Patient" do
        expect {
          post :create, params: { patient: invalid_attributes }
        }.to change(Patient, :count).by(0)
      end

      it "renders the 'new' template" do
        post :create, params: { patient: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT #update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { full_name: 'Updated John Doe', date_of_birth: 25.years.ago, patient_card_id: create(:patient_card).id }
      }

      it "updates the requested patient" do
        patient = Patient.create! valid_attributes
        put :update, params: { id: patient.to_param, patient: new_attributes }
        patient.reload
        expect(patient.full_name).to eq('Updated John Doe')
      end

      it "redirects to the patient" do
        patient = Patient.create! valid_attributes
        put :update, params: { id: patient.to_param, patient: new_attributes }
        patient.reload
        expect(response).to redirect_to(patient)
      end
    end

    context "with invalid parameters" do
      it "renders the 'edit' template" do
        patient = Patient.create! valid_attributes
        put :update, params: { id: patient.to_param, patient: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested patient" do
      patient = Patient.create! valid_attributes
      expect {
        delete :destroy, params: { id: patient.to_param }
      }.to change(Patient, :count).by(-1)
    end

    it "redirects to the patients list" do
      patient = Patient.create! valid_attributes
      delete :destroy, params: { id: patient.to_param }
      expect(response).to redirect_to(patients_url)
    end
  end
end
