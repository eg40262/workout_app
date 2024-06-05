Rails.application.routes.draw do
  devise_for :users

  root 'workouts#index'

  resources :workouts do
    resources :exercises, only: [:create, :update, :destroy]
    collection do
      get ':year/:month', to: 'workouts#index', as: 'filtered_workouts', constraints: { year: /\d{4}/, month: /\d{1,2}/ }
      # year: /\d{4}/: :year パラメータは4桁の数字でなければなりません。
      # month: /\d{1,2}/: :month パラメータは1桁または2桁の数字でなければなりません。
    end
  end
    # get 'workouts/:year/:month', to: 'workouts#index', as: 'filtered_workouts'
  # 月と年をパラメータとして受け取れるようにします
end
