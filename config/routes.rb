Rails.application.routes.draw do
  root 'events#index'
  resources :home
  resources :products
  resources :authors
  resources :books
  resources :students
  resources :faculties
  resources :users
  resources :cars
  resources :events
  resources :addresses
  resources :comments
  get '/search', to: 'cars#search'
  get '/login', to: 'users#login'
  get '/download_pdf', to: 'cars#download_pdf'
  get '/events/categories/search', to: 'events#search', as: "event_search"
  get '/enrollments', to: 'enrollments#index'
  get '/enrollments/create/:eventid', to: 'enrollments#create', as: "create_enrollment"
  get '/enrollments/discard/:eventid', to: 'enrollments#discard', as: "discard_enrollment"
  get '/profiles', to: 'profiles#index'
end
