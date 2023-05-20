Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
      resources :posts, only: [:create, :index, :show]
      resources :post_comments, only: [:create, :destroy]
      get "user/profile", to: 'users#get_profile'
      post "user/login", to: 'users#login'
    end
  end
end
