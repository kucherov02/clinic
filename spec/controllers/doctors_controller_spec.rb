require 'rails_helper'

RSpec.describe DoctorsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:department) { FactoryBot.create(:department) }
  let(:valid_attributes) { { full_name: 'Dr. Smith', date_of_joining: Date.today, department_id: department.id } }
  let(:invalid_attributes) { { full_name: '', date_of_joining: '', department_id: '' } }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'returns a success response' do
      Doctor.create! valid_attributes
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      doctor = Doctor.create! valid_attributes
      get :show, params: { id: doctor.to_param }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: {}
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      doctor = Doctor.create! valid_attributes
      get :edit, params: { id: doctor.to_param }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Doctor' do
        expect {
          post :create, params: { doctor: valid_attributes }
        }.to change(Doctor, :count).by(1)
      end

      it 'redirects to the created doctor' do
        post :create, params: { doctor: valid_attributes }
        expect(response).to redirect_to(Doctor.last)
      end
    end

    context 'with invalid params' do
      it 'does not create a new Doctor' do
        expect {
          post :create, params: { doctor: invalid_attributes }
        }.to change(Doctor, :count).by(0)
      end

      it "renders a 'new' template" do
        post :create, params: { doctor: invalid_attributes }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { full_name: 'Dr. Johnson' } }

      it 'updates the requested doctor' do
        doctor = Doctor.create! valid_attributes
        put :update, params: { id: doctor.to_param, doctor: new_attributes }
        doctor.reload
        expect(doctor.full_name).to eq('Dr. Johnson')
      end

      it 'redirects to the doctor' do
        doctor = Doctor.create! valid_attributes
        put :update, params: { id: doctor.to_param, doctor: new_attributes }
        doctor.reload
        expect(response).to redirect_to(doctor)
      end
    end

    context 'with invalid params' do
      it 'does not change the doctor' do
        doctor = Doctor.create! valid_attributes
        put :update, params: { id: doctor.to_param, doctor: { full_name: '' } }
        doctor.reload
        expect(doctor.full_name).to eq('Dr. Smith')
      end

      it "renders an 'edit' template" do
        doctor = Doctor.create! valid_attributes
        put :update, params: { id: doctor.to_param, doctor: { full_name: '' } }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested doctor' do
      doctor = Doctor.create! valid_attributes
      expect {
        delete :destroy, params: { id: doctor.to_param }
      }.to change(Doctor, :count).by(-1)
    end

    it 'redirects to the doctors list' do
      doctor = Doctor.create! valid_attributes
      delete :destroy, params: { id: doctor.to_param }
      expect(response).to redirect_to(doctors_url)
    end
  end
end
