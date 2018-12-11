Rails.application.routes.draw do
  resources :posts do
    resources :comments, only: [:index, :create, :destroy]
  end
end
