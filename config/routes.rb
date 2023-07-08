Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      get 'user/:id/experience', to: 'work_experience#other_user_experience'
      resources :authentication, only: [:create]
      get "authenticaation/login", to: 'login#authentication'
      get 'user/:id/followers', to: 'followers#other_user_followers'
      get 'search', to: 'search#query_search'

      namespace :auth do
        resources :post_comments, only: [:index, :create, :destroy]
        resources :posts, only: [:destroy, :create, :index, :show]
        resources :users_details, only: [:show]
        resources :follows, only:[:create, :index]
        get "user/posts", to: 'posts#current_user_posts'
        get "user/:id/posts", to: 'posts#other_users_posts'
        get "post/:id/like", to: 'post_likes#like_unlike'
        put "user/update_profile", to: 'users_details#update_profile'
        get "user/profile", to: 'users_details#get_profile'
        get 'user/:id/experience', to: 'work_experience#index'
        post 'user/experience', to: 'work_experience#create'
        put 'user/experience/:id', to: 'work_experience#update'
        delete "posts/:id/comments/:comment_id", to: "post_comments#destroy"
      end

      namespace :unauth do
        resources :posts, only: [:index, :show]
        resources :user_details, only: [:show]
        get 'user/:id/posts', to: 'posts#other_user_posts'
      end

    end
  end
end
