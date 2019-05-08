Rails.application.routes.draw do
  namespace :api do
    resources :sessions, only: [:create]
    resources :stickies, only: [:create, :index, :destroy, :update]
  end

  match '*path', to: 'landing#index', via: [:get, :post, :put, :patch, :delete]
  match '/', to: 'landing#index', via: [:get, :post, :put, :patch, :delete]
end
