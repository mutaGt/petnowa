Rails.application.routes.draw do
  
devise_for :members,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

devise_scope :member do
    post 'members/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'public/homes#top'
  scope module: :public do
    resources :members, only: [] do
      collection do
        get :reviews
        get :my_page
        get :edit
        patch :update
        get :password_edit
        patch :password_update
        get :unsubscribe
        patch :withdraw
      end
    end
    
    resources :reviews do
      collection do
        get :search
      end
      
      resources :comments, only: [:new, :create, :edit, :update, :destroy]
    end

  end
  
  namespace :admin do
    resources :reviews, only: [:index, :destroy]
    resources :tags, only: [:index, :create, :destroy]
    resources :members, only: [:index, :show, :update, :destroy]
    resources :comments, only: [:index, :destroy]
  end
  
end
