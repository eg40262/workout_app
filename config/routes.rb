Rails.application.routes.draw do
  devise_for :users
  get 'exercises/index'
  get 'exercises/show'
  get 'exercises/new'
  get 'exercises/create'
  get 'exercises/edit'
  get 'exercises/update'
  get 'exercises/destroy'
  get 'workouts/index'
  get 'workouts/show'
  get 'workouts/new'
  get 'workouts/create'
  get 'workouts/edit'
  get 'workouts/update'
  get 'workouts/destroy'
  root 'workouts#index'
  resources :workouts do
    resources :exercises
  end
end