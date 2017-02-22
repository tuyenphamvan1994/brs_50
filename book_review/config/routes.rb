Rails.application.routes.draw do
  resources :books do
    resources :reviews, except: [:show, :index]
    resources :favorite_books, only: [:create, :destroy]
    resources :comments, except: [:show, :index]
  end
  root "static_pages#show", page: "home"
  get "/static_pages/*page", to: "static_pages#show"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
   
 resources :relationships, only: [:index, :create, :destroy]
  namespace :admin do
    resources :categories, except: [:show]
    resources :books
    resources :requests, only: [:index, :update]
  end

  resources :users, only: [:index, :show, :destroy]
  resources :requests, except: [:edit, :update, :show]
end
