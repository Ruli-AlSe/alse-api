FactoryBot.define do
  factory :admin do
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 10, max_length: 20) }
    age { rand(30..100) }
    company
  end
end
