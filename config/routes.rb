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

  # ゲストログイン
  devise_scope :user do
    post "public/guest_sign_in", to: "public/sessions#guest_sign_in"
  end

  # 管理者側のルーティング
  namespace :admin do
    get '/' => 'homes#top'

    # チャット画面
    get "groups/:id/chat" => "groups#chat", as: :group_chat

    resources :users, only: [:index, :show, :destroy]
    resources :posts do
      resources :post_comments, only: [:create, :destroy]
    end
    resources :groups, only: [:index, :show, :destroy] do
      resource :group_users, only: [:create, :destroy] do
        member do
          post 'reject'
        end
      end
      resources :group_chats, only: [:destroy]
    end
  end

  # ユーザー側のルーティング
  scope module: :public do
    root :to =>"homes#top"
    get "about" => "homes#about"

    # コミュニティ参加申請車一覧
    get "groups/:id/permits" => "groups#permits", as: :permits

    # チャット画面
    get "groups/:id/chat" => "groups#chat", as: :group_chat

    resources :users, only: [:edit, :show, :update, :destroy]
    resources :posts do
      resources :post_comments, only: [:create, :destroy]
    end
    resources :groups, only: [:new, :index, :show, :edit, :create, :update, :destroy] do
      resource :permits, only: [:create, :destroy]
      resource :group_users, only: [:create, :destroy] do
        member do
          post 'reject'
        end
      end
      resources :group_chats, only: [:create, :destroy]
    end
  end

  # 検索機能
  get "search" => "searches#search"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
