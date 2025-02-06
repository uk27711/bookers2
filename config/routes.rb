Rails.application.routes.draw do
  get "lists/new"
  get "lists/index"
  get "lists/show"
  get "lists/edit"
  devise_for :users
  root to: 'homes#top'
  get 'homes/about', to: 'homes#about', as: :about
  resources :post_images, only: [:new, :create, :index, :show, :destroy] do
    resource :favorite, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit, :update]
end
