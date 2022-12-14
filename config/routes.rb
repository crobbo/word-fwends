Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :games do
    resources :guesses
  end

  resources :players do
    patch :status
  end

  root to: 'games#index'
end
