Rails.application.routes.draw do
    devise_for :users, controllers: {
      registrations: "auth/registrations",
      sessions: "auth/sessions",
      confirmations: "auth/confirmations",
      passwords: "auth/passwords"
    }

  # Root route
  root "posts#index"

  # Resources
  resources :posts do
    resources :comments

    member do
      post :report
    end
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

  match "/404", to: "errors#not_found", via: :all
end
