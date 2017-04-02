Rails.application.routes.draw do

  root to: 'companies#index'

  resources :companies do
    resources :jobs do
      resources :comments, only: [:new]
    end
  end

  resources :categories

end
