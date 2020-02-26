Rails.application.routes.draw do
  namespace :api do
    resources :sessions, only: [:create]
    resources :stickies, only: [:create, :index, :destroy, :update]
  end

  match '/', to: 'landing#index', via: [:get, :post, :put, :patch, :delete]
  match '/dashboard', to: 'landing#index', via: [:get, :post, :put, :patch, :delete]
  match '/projects', to: 'landing#index', via: [:get, :post, :put, :patch, :delete]
end
