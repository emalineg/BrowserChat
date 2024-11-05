Rails.application.routes.draw do
  resources :messages, only: [:index, :create]
  root 'messages#home'
end
