Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create, :show]
      resources :posts, only: [:create, :index, :show]
      resources :post_comments, only: [:show, :create]
      resources :post_likes, only: [:show, :create, :destroy]
      resources :work_experience, only: [:index, :create]
      get "user/profile", to: 'users#get_profile'
      post "user/login", to: 'users#login'
      delete "posts/:id/comments/:comment_id", to: "post_comments#destroy"
    end
  end
end
