Rails.application.routes.draw do
 devise_for :users, controllers: {
    registrations: "auth/registrations",
    sessions: "auth/sessions"
  }
  resources :home

  root "home#index"
end
