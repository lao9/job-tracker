Rails.application.routes.draw do

  root to: 'companies#index'

  resources :companies do
    resources :jobs
  end

  resources :jobs do
    resources :comments
  end

  resources :categories

end
