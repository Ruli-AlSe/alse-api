FactoryBot.define do
  factory :project do
    name { Faker::App.name }
    description { Faker::Lorem.sentence }
    company_name { Faker::Company.name }
    live_url { Faker::Internet.url }
    repository_url { Faker::Internet.url }
    company
  end
end
