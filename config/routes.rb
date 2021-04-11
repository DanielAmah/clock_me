Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  post '/login', to: 'sessions#login'
  resources :users, only: [:create]
  resources :professions, only: [:index, :create, :destroy]
  resources :events, only: [:index, :create, :destroy, :update]
  put '/events/:id/trash_event', to: 'events#trash_event'
  get '/user_events', to: 'events#user_events'
  put 'events/:id/clock_out', to: 'events#clock_out'

  root 'index#index'
  get '*path', to: 'index#index'
end
