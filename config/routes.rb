Rails.application.routes.draw do
  # ユーザー用　ログイン・ログアウト
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  # 管理者用　ログイン・ログアウト
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }

  # 管理者側のルーティング
  namespace :admin do
    get '/' => 'homes#top'
  end

  # ユーザー側のルーティング
  scope module: :public do
    root :to =>"homes#top"
    get "about" => "homes#about"

    resources :users, only: [:edit, :show, :update, :destroy] do
      get "mypage", on: :collection, to: "users#mypage"
    end

  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
