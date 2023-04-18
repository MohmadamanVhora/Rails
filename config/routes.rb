Rails.application.routes.draw do
  root 'products#index'
  get '/search', to: 'cars#search'
  get '/login', to: 'users#login'
  get '/download_pdf', to: 'cars#download_pdf'
  get '/events/categories/search', to: 'events#search', as: "event_search"
  get '/enrollments', to: 'enrollments#index'
  get '/enrollments/create/:eventid', to: 'enrollments#create', as: "create_enrollment"
  get '/enrollments/discard/:eventid', to: 'enrollments#discard', as: "discard_enrollment"
  get '/profiles', to: 'profiles#index'
  get '/comments/new/:eventid', to: 'comments#new', as: "create_comment"
  get '/likes/create/:commentid', to: 'likes#create', as: "like"
  get '/likes/destroy/:commentid', to: 'likes#destroy', as: "dislike"
  get '/employees/email/search', to: 'employees#search', as: "search_employee_email"
  get '/employees/change_order/:order/:id', to: 'employees#change_order', as: "change_order"
  get '/employees/first_10_employees', to: 'employees#first_ten_employees', as: "first_ten_employees"
  get '/employees/tasks', to: 'employees#task', as: "tasks"

  get '/products/active_products', to: 'products#active_products', as: "active_products"
  get '/orders/filter', to: 'orders#filter', as: "filter_orders"
  get '/orders/search', to: 'orders#search', as: "search_orders"
  
  resources :home
  
  resources :products do
    resources :orders, only: [:new]
  end
  
  resources :authors
  resources :books
  resources :students
  resources :faculties
  resources :users
  resources :cars
  resources :events
  resources :addresses
  resources :comments
  resources :employees
  resources :orders, except: [:new]

  namespace :business do
    resources :customers, except: %i[show destroy] do
      get '/preview', to: 'customers#preview', on: :member
      delete '/delete', to: 'customers#delete_customer', on: :member
      get '/search', to: 'customers#search', on: :collection
    end
    get '/customers/task/:task_id', to: 'customers#task', as: "task"
  end

  namespace :api do
    namespace :v1 do
      resources :verifications, only: [:index]
      get '/products', to: 'verifications#products', defaults: { format: 'json' }
      get '/orders', to: 'verifications#orders', defaults: { format: 'json' }
      get '/customers', to: 'verifications#customers', defaults: { format: 'json' }
    end
  end
end
