FactoryBot.define do
  factory :post do
    title { Faker::Book.title }
    content { Faker::Lorem.sentence(word_count: 50) }
    credits { "(#{Faker::Internet.domain_name}, #{Faker::Internet.domain_word}, #{Faker::FunnyName.name})" }
    image_url { Faker::Internet.url }
    slug { Faker::Book.title.parameterize }
    company
    category
  end
end
