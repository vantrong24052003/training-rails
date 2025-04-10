  Rails.application.routes.draw do
    devise_for :users, controllers: {
      registrations: "auth/registrations",
      sessions: "auth/sessions",
    }

  # Root route
  root "posts#index"

  # Resources
  resources :posts do
    resources :comments
  end

  resources :categories

  resource :profile

  # namespace
  namespace :admin do
    get "/", to: "dashboard#index", as: :dashboard

    resources :posts
    resources :categories
    resources :comments

    resources :users do
      member do
        patch :update_role
      end
    end
  end

  # Custom routes
  get '/confirm_email', to: 'auth/confirmations#confirm_email'

  match "/404", to: "errors#not_found", via: :all
end
