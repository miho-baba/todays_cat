Rails.application.routes.draw do
  #管理者用
  devise_for :admins,skip: [:passwords], controllers: {
    sessions: "admin/sessions",
    registrations: 'admin/registrations'
  }

  namespace :admin do
    get "/" => "homes#top"
    get "admins/mypage" => "admins#show"
  end

  #会員用
  devise_for :customers,skip: [:passwords], controllers: {
    sessions: "customer/sessions",
    registrations: 'customer/registrations'
  }
  namespace :user do
    root "homes#top"
    get "customers/mypage" => "customers#show"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
