Rails.application.routes.draw do
     resources :users
     resources :microposts,          only: [:create, :destroy]
     get 'sessions/new'
     root "top#index"
     get  "top/profile"

     get    'users'  => 'users#index'
     get    'user'  => 'users#other'
     get    'signup'  => 'users#new'
     get    'login'   => 'sessions#new'
     post   'login'   => 'sessions#create'
    delete 'logout'  => 'sessions#destroy'
  end
