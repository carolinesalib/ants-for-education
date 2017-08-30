Rails.application.routes.draw do
  get 'series/index'
  get 'series/sync'

  get 'courses/index'
  get 'courses/sync'

  get 'sync/index'

  get 'schools/index'
  get 'schools/sync'

  devise_for :users

  root 'welcome#index'

  get 'welcome/index'

  get 'classrooms/sync'

  resources :ieducar_configurations, only: [:edit, :update]
  resources :classrooms, only: [:index, :show]
  resources :teachers, only: [:index, :show]
end
