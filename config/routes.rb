Rails.application.routes.draw do
  namespace :admin do
    root 'application#index'
  end
  root "projects#index"
  devise_for :users
  resources :projects do
    resources :ticketes
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
