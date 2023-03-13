Rails.application.routes.draw do
  root 'home#index'
  resources :products
  resources :authors
  resources :books
  resources :students
  resources :faculties
end
