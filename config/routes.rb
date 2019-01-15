Rails.application.routes.draw do
  namespace :admin do
    root 'application#index'

    resources :projects, only: [:new, :create, :destroy]
    resources :users do
      # member route
      member do
        patch :archive
      end
    end
  end
  root "projects#index"
  devise_for :users

  resources :projects, only: [:index, :show, :edit, :update] do
    resources :ticketes
  end

  resources :ticketes, only: [] do
    resources :comments, only: [:create]
  end

  resources :attachments, only: [:show, :new]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
