Rails.application.routes.draw do

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users, except: [:index, :show] do
    member do
      get :my_reservation
    end
  end

  root to: 'shops#index'
  resources :shops do
    member do
      get :canceled
      get :entered
      delete :reset
    end
    collection do
      get :my_shop
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
