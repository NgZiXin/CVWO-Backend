Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # Refer to rails routes
      # Standard CRUD Operations Routes Set-up
      resources :comments
      resources :main_threads

      # Custom Routes Set-up
      get "/main_threads/:id/comments", to: "main_threads#get_comments"
      get "/main_threads/:id/likes", to: "main_threads#get_likes"
      get "/categories", to: "categories#index"
      get "/categories/:id", to: "categories#show"
      get "/users", to: "users#index"
      get "/users/:id", to: "users#show"
      post "/users/signup", to: "users#create"
      patch "/users/:id", to: "users#update"
      get "/me", to: "auth#me"
      get "/me/history", to: "auth#history"
      post "/login", to: "auth#login"
      post "/likes", to: "likes#create"
      delete "/likes/:id", to: "likes#destroy"
    end
  end


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
