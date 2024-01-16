Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'pages#search'

  # search_path (simple form)
  get 'search', to: 'pages#search'

  resources :books, only: [:index, :new, :create, :destroy]
end
