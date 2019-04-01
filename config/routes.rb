Rails.application.routes.draw do
  match '*path', to: 'landing#index', via: [:get, :post, :put, :patch, :delete]
  match '/', to: 'landing#index', via: [:get, :post, :put, :patch, :delete]
end
