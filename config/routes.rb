Rails.application.routes.draw do
  resources :infos, :except => [:index]

  resources :comments, :only => [:create]

  post '/rate' => 'rater#create', :as => 'rate'
  resources :categories

  devise_for :users
  resources :users, :only => [:show] do
    member do
      get 'follow'
      resources :votes, :only => [:new, :create]
    end
  end
  resources :orders
  resources :order_items do
    collection do
      get 'buy'
      get 'delivered'
    end
    member do
      get 'product_orders'
    end
  end 
  resources :products
  
  root 'products#index'

  get "mailbox/inbox" => "mailbox#inbox", as: :mailbox_inbox
  get "mailbox/sent" => "mailbox#sent", as: :mailbox_sent
  get "mailbox/trash" => "mailbox#trash", as: :mailbox_trash


  resources :conversations do
    member do
      post :reply
      post :trash
      post :untrash
    end
  end
  get '/comments/new/(:parent_id)', to: 'comments#new', as: :new_comment
  get '/searching', to: 'products#searching', as: :searching
  get 'sort/:sort', to: 'products#sort_list', as: :sort
  
end
