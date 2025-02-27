Rails.application.routes.draw do
  devise_for :users
  post 'users' => 'users#create'
  root to: 'homes#top'
  get 'homes/about', to: 'homes#about', as: :about
    resources :users, only: [:new, :create, :show, :edit, :update, :index, :destroy] do
  end 
    resources :books, only: [:new, :create, :show, :edit, :update, :index, :destroy] do
  end
end

