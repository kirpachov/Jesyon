Rails.application.routes.draw do
  resources :categories
  devise_for :users
  get 'home/aboutUs'
  resources :activities
  root 'activities#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
