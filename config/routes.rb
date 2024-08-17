Rails.application.routes.draw do
  get 'importer/import_models'
  get 'importer/import_metadata'
  resources :sd_model_prompts
  resources :sd_prompts
  resources :sd_models
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  post 'sd_model_prompts/:id/regen', to: 'sd_model_prompts#regen', as: 'regenerate_image'
  post 'fix_stuck', to: 'importer#fix_stuck_model_prompts', as: 'fix_stuck_model_prompts'
  post 'clear_prompts', to: 'importer#delete_all_model_prompts', as: 'clear_prompts'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "sd_models#index"
end
