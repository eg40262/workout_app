Rails.application.routes.draw do
  devise_for :users
  
  root 'workouts#index'

  resources :workouts do
    resources :exercises
  end
end