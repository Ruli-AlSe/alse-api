FactoryBot.define do
  factory :category do
    title { Faker::Commerce.department }
    description { Faker::Lorem.sentence }
    slug { Faker::Commerce.department.parameterize }
  end
end
