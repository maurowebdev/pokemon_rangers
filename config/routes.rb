Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  resources :incidents
  root 'incidents#index'

  resources :rangers, only: %i[create update]

  post '/sign_in', to: 'sessions#create'
  post '/sign_up', to: 'rangers#create'
  get '/open_cases', to: 'open_cases#show'
end
