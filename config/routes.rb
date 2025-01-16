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
      resources :profiles, only: %i[show update]
      resources :categories, only: %i[index create update destroy]
      resources :skills, only: %i[create update destroy]
      resources :educations, only: %i[create update destroy]
      resources :posts, only: %i[index create update destroy] do
        # "v1/posts/:post_id/restore"
        post 'restore'
      end
    end
  end
end
