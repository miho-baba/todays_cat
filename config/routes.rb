Rails.application.routes.draw do
  #管理者用
  devise_for :admins,skip: [:passwords], controllers: {
    sessions: "admin/sessions",
    registrations: 'admin/registrations'
  }
  #ルートパスの記述
  get "/" => "user/homes#top"
  namespace :admin do
    get "/" => "homes#top"
    get "mypage" => "mypages#show"
    resources :admins, only: [:show]
    resources :customers, only: [:index, :show, :edit, :update]
    get "/search", to: "searches#search"
  end

  #会員用
  devise_for :customers,skip: [:passwords], controllers: {
    sessions: "customer/sessions",
    registrations: 'customer/registrations'
  }

  namespace :customer do
    resources :mypages, only: [:show, :edit, :create, :update, :index]
    resources :customers, only: [:index, :show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      	get "followings" => "relationships#followings", as: "followings"
      	get "followers" => "relationships#followers", as: "followers"
      collection do
        get :mypage
      end
    end

    resources :photos, only: [:index, :show, :edit, :update, :create, :destroy] do
      resources :photo_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
    get "/search", to: "searches#search"
  end

  namespace :user do
    root "homes#top"
    resources :customers, only: [:show]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
