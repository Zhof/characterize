Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :characters, except: [:edit, :update]
  resources :generations, only: [:new]
  get 'generations/generate_story', to: 'generations#generate_story', as: 'generate_story'
  get 'generations/generate_sentence', to: 'generations#generate_sentence', as: 'generate_sentence'
  get '/tavern', to: 'characters#tavern', as: 'tavern'
  post 'characters/:id/share', to: 'characters#share', as: 'shared_character'
  post 'characters/:id/buy_pint', to: 'characters#buy_pint', as: 'buy_pint'
end
