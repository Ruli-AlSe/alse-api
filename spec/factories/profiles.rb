FactoryBot.define do
  factory :profile do
    name { Faker::Superhero.name }
    last_name { Faker::Name.last_name }
    image_url { Faker::Avatar.image }
    about_me { Faker::Lorem.paragraph(sentence_count: 5) }
    headliner { Faker::Quote.yoda }
    bio { Faker::Quote.matz }
    city { Faker::Address.city }
    state { Faker::Address.state }
    country { Faker::Address.country }
    phone_number { Faker::PhoneNumber.cell_phone }
    social_media {
      "#{Faker::Internet.url},#{Faker::Internet.url},#{Faker::Internet.url},#{Faker::Internet.url},#{Faker::PhoneNumber.cell_phone},#{Faker::Internet.url}"
    }
    profilable { association :owner }
  end
end
