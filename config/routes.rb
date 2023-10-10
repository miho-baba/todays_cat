Rails.application.routes.draw do
  #管理者用
  devise_for :admins,skip: [:passwords], controllers: {
    seessions: "admin/seessions",
    registrations: 'admin/registrations'
  }

  namespace :admin do
    get "/" => "homes#top"
  end

  #会員用
  devise_for :customers,skip: [:passwords], controllers: {
    seessions: "customer/seessions",
    registrations: 'customer/registrations'
  }
  namespace :user do
    root "homes#top"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
