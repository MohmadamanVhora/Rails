Rails.application.routes.draw do
  root 'home#index'
  resources :products
  resources :authors
  resources :books
  resources :students
  resources :faculties
  resources :users
  resources :cars
  get '/search', to: 'cars#search'
  get '/download_pdf', to: 'cars#download_pdf'
end
