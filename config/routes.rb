Rails.application.routes.draw do
  devise_for :users
  root to: "private_rooms#index"
end
