Rails.application.routes.draw do

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users, except: [:index, :show]

  root to: 'shops#index'
  resources :shops do
    member do
      get :canceled
      get :entered
    end
    collection do
      get :my_index
    end
    resources :reservations, only: [:show, :new, :create, :destroy] do
      member do
        patch :cancel
        patch :enter
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
