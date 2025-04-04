Rails.application.routes.draw do
 devise_for :users, controllers: {
    registrations: "auth/registrations",
    sessions: "auth/sessions"
  }
  resources :home

  namespace :admin do
   get "dashboard", to: "dashboard#index"
   
  end

  root "home#index"
end
