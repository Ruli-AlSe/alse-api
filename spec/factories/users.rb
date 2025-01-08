FactoryBot.define do
  factory :user do
    email { "raul@example.com" }
    age { 18 }
    password_digest { "MyString" }
    type { "test" }
  end
end
