Rails.application.routes.draw do
  devise_for :users
  post 'books' => 'books#create'
  root to: 'homes#top'
  get 'homes/about', to: 'homes#about', as: :about
    resources :users, only: [:new, :show, :edit, :update, :index]
    resources :books, only: [:new, :create, :index, :show, :destroy, :edit] do
  end
end
