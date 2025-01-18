Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  scope '(:locale)', locale: /es|en/ do
    get 'home/greetings'

    namespace :v1, defaults: { format: :json } do
      resources :users, only: %i[create] do
        # "v1/users/login"
        post 'login', on: :collection
      end
      resources :companies, only: %i[show]
      resources :profiles, only: %i[update]
      get 'profiles/:email', to: 'profiles#show', constraints: { email: /[^\/]+/ }
      get 'categories/:email', to: 'categories#index', constraints: { email: /[^\/]+/ }
      resources :categories, only: %i[create update destroy]
      resources :skills, only: %i[create update destroy]
      resources :educations, only: %i[create update destroy]
      resources :jobs, only: %i[create update destroy]
      resources :projects, only: %i[index create update destroy]
      get 'posts/:email', to: 'posts#index', constraints: { email: /[^\/]+/ }
      resources :posts, only: %i[create update destroy] do
        # "v1/posts/:post_id/restore"
        post 'restore'
      end
    end
  end
end
