Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :characters, except: [:edit, :update]
  resources :generations, only: [:new]
  get 'generations/generate_story', to: 'generations#generate_story', as: 'generate_story'
end
