Rails.application.routes.draw do
  get 'series/index'
  get 'series/sync'

  get 'courses/index'
  get 'courses/sync'

  get 'sync/index'


  devise_for :users

  root 'welcome#index'

  get 'welcome/index'

  get 'classrooms/sync'

  resources :ieducar_configurations, only: [:edit, :update]
  resources :classrooms, only: [:index, :show]
  resources :teachers, only: [:index, :show]

  resources :schools, only: [ :none ] do
    collection do
      get 'index'
      get 'sync'
    end
  end
end
