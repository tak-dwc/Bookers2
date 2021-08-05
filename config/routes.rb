Rails.application.routes.draw do
  get 'tests/top'
  get 'searches/search'
  devise_for :users
  root to: 'homes#top'
  get "home/about" => "homes#about" 
  get "/search" => "searches#search"
  
  resources :users,only: [:index,:show,:edit,:update,] do 
    resource :relationships, only: [:create,:destroy]
   get 'followings' => 'relationships#followings',as: 'followings'
   get 'followers' => 'relationships#followers' ,as: 'followers'
  
  end  
  
  resources :messages,only: [:create]
  resources :rooms,only: [:create,:show]
  
  resources :books,only: [:index,:create,:show,:edit,:update,:destroy] do
    resource :favorites ,only:[:create, :destroy]
    
    resources :book_comments,only: [:create,:destroy]
  end  
  
end

