Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root "hospitals#root_page"

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  get 'hospitals/download_csv', to: 'hospitals#download_csv', as: :download_csv

  resources :patients
  resources :patient_cards
  resources :specialties
  resources :doctors
  resources :departments
  resources :hospitals do
    collection do
      get 'download_pdf'
    end
  end
end
