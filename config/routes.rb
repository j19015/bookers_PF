Rails.application.routes.draw do
  get 'searches/search'
  get 'serches/search'
  root to: 'homes#top'
  get '/home/about'=>"homes#about",as: "about"
  devise_for :users
  resources :users,only: [:index, :show, :update, :edit] do
    resource :relationships,only:[:create,:destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
  	get 'followers' => 'relationships#followers', as: 'followers'
  end
  resources :books do
    resource :favorites,only: [:create,:destroy]
    resources :book_comments,only: [:create,:destroy]
  end

  resources :groups do
    resource :group_users
  end
  post 'searches'=>"searches#search",as: 'search'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
