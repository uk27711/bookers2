Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'homes/about', to: 'homes#about', as: :about
    resources :users, only: [:show, :edit, :update, :index]
    resources :books, only: [:new, :create, :index, :show, :destroy, :edit] do
    resource :favorite, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end
end
