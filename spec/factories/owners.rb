FactoryBot.define do
  factory :owner do
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 10, max_length: 20) }
    age { rand(30..100) }
    company

    factory :owner_company_categories do
      email { Faker::Internet.email }
      password { Faker::Internet.password(min_length: 10, max_length: 20) }
      age { rand(30..100) }
      company { association :company_with_categories }
    end
  end
end
