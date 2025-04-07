Rails.application.routes.draw do
 devise_for :users, controllers: {
    registrations: "auth/registrations",
    sessions: "auth/sessions"
  }
   root "posts#index"

  namespace :admin do
    resources :posts, except: [ :show ]
  end

  resources :posts, only: [ :index, :show, :new, :create ]
end
