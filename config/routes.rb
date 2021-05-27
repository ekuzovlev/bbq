Rails.application.routes.draw do
  devise_for :users, path_names: { sign_in: :login, sign_out: :logout },
                     controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'events#index'

  resources :events do
    resources :comments, only: [:create, :edit, :update, :destroy]
    resources :subscriptions, only: [:create, :destroy]
    resources :photos, only: [:create, :destroy]
    post :show, on: :member
  end
  resources :users, only: %i[show edit update]
end
