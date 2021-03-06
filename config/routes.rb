Rails.application.routes.draw do
  devise_for :users
  root :to => 'homes#home'
  get 'home/about' => 'homes#about'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :books, only: [:create, :show, :index, :edit, :update, :destroy]
  resources :users, only: [:show, :edit, :update, :index]
  
end
