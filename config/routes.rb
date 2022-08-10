Rails.application.routes.draw do
  
devise_for :members,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'public/homes#top'
  scope module: :public do
    get '/members/my_page' => 'members#show'
    get '/members/reviews' => 'members#index'
    get '/members/information/edit' => 'members#edit'
    patch '/members/information' => 'members#update'
    #会員の退会確認画面
    get '/members/unsubscribe' => 'members#unsubscribe'
    #会員ステータスの更新
    patch '/members/withdraw' => 'members#withdraw'
    # get '/reviews/search' => 'reviews#search'
    #↑非同期を導入するなら必要
    resources :comments, only: [:new, :create, :edit, :update]
    resources :reviews
  end
  
  namespace :admin do
    resources :reviews, only: [:index, :destroy]
    resources :tags, only: [:index, :create, :destroy]
    resources :members, only: [:index, :show, :update, :destroy]
    resources :comments, only: [:index, :destroy]
  end
  
end
