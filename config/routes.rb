Rails.application.routes.draw do
  # registration_controllerの記述を有効にするために記載
  devise_for :users, controllers: {
                       registrations: "users/registrations",
                     }
  root to: "top#index"
  resources :users, only: :show
  resources :relationships, only: [:create, :destroy]
  resources :open_rooms, except: [:destroy] do
    resources :open_messages, only: :create
    member do
      post "join"
      delete "exit"
    end
    collection do
      get "search"
    end
  end
  resources :private_rooms, except: [:destroy] do
    resources :private_messages, only: :create
    member do
      post "add_member"
      delete "exit"
    end
    collection do
      post "simple_chat"
    end
  end
  resources :tweets, except: [:edit, :update] do
    collection do
      get "all"
      get "search"
    end
  end
end
