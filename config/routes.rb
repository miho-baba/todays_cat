Rails.application.routes.draw do
  #管理者用
  devise_for :admins,skip: [:passwords], controllers: {
    sessions: "admin/sessions",
    registrations: 'admin/registrations'
  }

  namespace :admin do
    get "/" => "homes#top"
    get "mypage" => "mypages#show"
    resources :admins, only: [:show]
  end

  #会員用
  devise_for :customers,skip: [:passwords], controllers: {
    sessions: "customer/sessions",
    registrations: 'customer/registrations'
  }

  namespace :customer do
    get "mypage" => "mypages#show"
    # resources :customers, only: [:show]
  end

  namespace :user do
    root "homes#top"
    # get "customers/mypage" => "customers#show"
    resources :customers, only: [:show]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
