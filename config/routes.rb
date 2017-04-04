Rails.application.routes.draw do

  root to: 'companies#index'

  resources :companies do
    resources :jobs
    resources :contacts, only: [:create]
  end

  resources :jobs, only: [:show] do
    resources :comments, only: [:create]
  end

  resources :categories

  scope module: :list do
    resources :jobs, only: [:index]
  end

end
