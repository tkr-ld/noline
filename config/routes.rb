Rails.application.routes.draw do

  root to: 'top_pages#index'

  get '/home', to: 'top_pages#index'
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get 'auth/:provider/callback', to: 'sessions#create'

  resources :users, except: [:index, :show] do
    member do
      get :my_reservation
      get :my_reserved_shop
    end
  end

  resources :shops do
    member do
      get :canceled
      get :entered
      delete :reset
    end
    collection do
      get :my_shop
    end
    resources :reservations, only: [:show, :new, :create, :update, :destroy] do
      member do
        patch :cancel
        patch :enter
      end
    end
  end

  resources :relationships, only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
