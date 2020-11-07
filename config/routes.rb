Rails.application.routes.draw do
  # registration_controllerの記述を有効にするために記載
  devise_for :users, controllers: {
                       registrations: "users/registrations",
                     }
  root to: "private_rooms#index"
  resources :users, only: :show
  resources :relationships, only: [:create, :destroy]
  resources :open_rooms, only: [:index, :new, :create, :show] do
    resources :open_messages, only: :create
    member do
      post "add_member"
    end
  end
end
