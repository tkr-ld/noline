Rails.application.routes.draw do

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users, except: [:index, :show]

  root to: 'shops#index'
  resources :shops do
    get :my_index, on: :collection
    resources :reservations, only: [:show, :new, :create, :destroy] do
      patch :cancel
      patch :enter
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
