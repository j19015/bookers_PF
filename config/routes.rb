Rails.application.routes.draw do
  get 'searches/search'
  get 'serches/search'
  root to: 'homes#top'
  get '/home/about' => 'homes#about', as: 'about'
  devise_for :users
  resources :users, only: %i[index show update edit] do
    resource :relationships, only: %i[create destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  resources :books do
    resource :favorites, only: %i[create destroy]
    resources :book_comments, only: %i[create destroy]
  end

  resources :groups do
    get 'mail/new'=>"groups#new_mail",as:"new_mail"
    post 'mail/send_mail'=> "groups#send_mail",as:"send_mail"
    resource :group_users
  end
  get 'messages/:id' => 'messages#message', as: 'message'
  post 'messages' => 'messages#create', as: 'messages'
  post 'searches' => 'searches#search', as: 'search'
  post 'day_search_book'=>"users#day_search_book",as: 'day_search_book'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
