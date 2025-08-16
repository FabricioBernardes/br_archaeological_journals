Rails.application.routes.draw do
  resources :authors
  resources :bibliographic_references do
    collection do
      get :fetch_doi
    end
  end
  resources :articles
  resources :editions
  resources :scientific_journals
  resources :keywords, defaults: { format: :json }
  resources :author_refs, only: [:index, :create]
  devise_for :users
  get "home/index"

  root "home#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check


  # Blog static pages
  get 'blog', to: 'blog#index', as: :blog
  get 'blog/:id', to: 'blog#show', as: :blog_post

  # Defines the root path route ("/")
  # root "posts#index"

  resources :users, only: [:index] do
    member do
      get :edit_role
      patch :update_role
      get :edit
      patch :update
    end
  end
end
