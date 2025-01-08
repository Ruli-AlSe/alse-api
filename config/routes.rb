Rails.application.routes.draw do
  scope '(:locale)', locale: /es|en/ do
    get 'home/greetings'

  end
end
