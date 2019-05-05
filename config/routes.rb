Rails.application.routes.draw do
  namespace :api do
    resources :sessions, only: [:create, :index]
  end

  match '*path', to: 'landing#index', via: [:get, :post, :put, :patch, :delete]
  match '/', to: 'landing#index', via: [:get, :post, :put, :patch, :delete]
end
