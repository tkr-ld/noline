Rails.application.routes.draw do
  resources :users, except: [:index, :show]

  root to: 'shops#index'
  resources :shops
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
