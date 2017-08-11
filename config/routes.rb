Rails.application.routes.draw do
  get 'courses/index'

  get 'sync/index'

  get 'schools/index'

  devise_for :users

  root 'welcome#index'

  get 'welcome/index'

  resources :ieducar_configurations, only: [:edit, :update]
end
