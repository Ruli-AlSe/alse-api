FactoryBot.define do
  factory :category do
    title { Faker::Commerce.department }
    description { Faker::Lorem.sentence }
    slug { "#{rand(1..100)} #{Faker::Commerce.department.parameterize}" }
    company
  end
end
