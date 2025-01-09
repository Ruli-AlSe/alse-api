Rails.application.routes.draw do
  scope '(:locale)', locale: /es|en/ do
    get 'home/greetings'

    namespace :v1, defaults: { format: :json } do
      resources :users, only: %i[create] do
        post 'login', on: :collection
      end
      resources :stores, only: %i[show]
      resources :products, only: %i[index create update]
    end
  end
end
