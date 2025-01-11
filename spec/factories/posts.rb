FactoryBot.define do
  factory :post do
    name { Faker::Book.title }
    description { Faker::Lorem.sentence(word_count: 50) }
    price { rand(10..100) }
    company
  end
end
