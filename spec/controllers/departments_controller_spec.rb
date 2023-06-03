require 'rails_helper'

RSpec.describe DepartmentsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:hospital) { FactoryBot.create(:hospital) }
  let(:valid_attributes) { { name: 'Cardiology', number: 1, creation_date: Date.today, hospital_id: hospital.id } }
  let(:invalid_attributes) { { name: '', number: '', creation_date: '', hospital_id: '' } }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'returns a success response' do
      Department.create! valid_attributes
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      department = Department.create! valid_attributes
      get :show, params: { id: department.to_param }
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
      department = Department.create! valid_attributes
      get :edit, params: { id: department.to_param }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Department' do
        expect {
          post :create, params: { department: valid_attributes }
        }.to change(Department, :count).by(1)
      end

      it 'redirects to the created department' do
        post :create, params: { department: valid_attributes }
        expect(response).to redirect_to(Department.last)
      end
    end

    context 'with invalid params' do
      it 'does not create a new Department' do
        expect {
          post :create, params: { department: invalid_attributes }
        }.to change(Department, :count).by(0)
      end

      it "renders a 'new' template" do
        post :create, params: { department: invalid_attributes }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { name: 'Neurology' } }

      it 'updates the requested department' do
        department = Department.create! valid_attributes
        put :update, params: { id: department.to_param, department: new_attributes }
        department.reload
        expect(department.name).to eq('Neurology')
      end

      it 'redirects to the department' do
        department = Department.create! valid_attributes
        put :update, params: { id: department.to_param, department: new_attributes }
        department.reload
        expect(response).to redirect_to(department)
      end
    end

    context 'with invalid params' do
      it 'does not change the department' do
        department = Department.create! valid_attributes
        put :update, params: { id: department.to_param, department: { name: '' } }
        department.reload
        expect(department.name).to eq('Cardiology')
      end

      it "renders an 'edit' template" do
        department = Department.create! valid_attributes
        put :update, params: { id: department.to_param, department: { name: '' } }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested department' do
      department = Department.create! valid_attributes
      expect {
        delete :destroy, params: { id: department.to_param }
      }.to change(Department, :count).by(-1)
    end

    it 'redirects to the departments list' do
      department = Department.create! valid_attributes
      delete :destroy, params: { id: department.to_param }
      expect(response).to redirect_to(departments_url)
    end
  end
end
