Rails.application.routes.draw do
  devise_for :users, controllers: {
                       registrations: "users/registrations",
                     }
  root to: "private_rooms#index"
  resources :users, only: :show
end
