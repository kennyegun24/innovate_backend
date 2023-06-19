Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create, :show]
      resources :posts, only: [:destroy, :create, :index, :show]
      resources :post_comments, only: [:show, :create]
      resources :post_likes, only: [:show]
      resources :work_experience, only: [:index, :create, :update]
      resources :unauths, only:[:show]
      get "user/profile", to: 'users#get_profile'
      get "all/posts", to: 'posts#authenticated_index'
      get "auth/post/:id", to: 'posts#authenticated_show'
      get "auth/user/posts", to: 'posts#current_user_posts'
      get "user/:id/posts", to: 'posts#other_user_posts'
      post 'posts/:id/likes', to: 'post_likes#create_destroy'
      put "user/update_profile", to: 'users#update_profile'
      get "user/image", to: 'posts#show_image'
      post "user/login", to: 'users#login'
      delete "user/delete", to: 'users#destroy'
      delete "posts/:id/comments/:comment_id", to: "post_comments#destroy"
      get 'search', to: 'search#query_search'

      resources :followers, only: %i[create]
    end
  end
end
