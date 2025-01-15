FactoryBot.define do
  factory :skill do
    name { Faker::ProgrammingLanguage.name }
    icon_url { Faker::Avatar.image }
    level { Faker::Number.between(from: 1, to: 5) }
    category
    profile
  end
end
