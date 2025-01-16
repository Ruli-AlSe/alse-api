FactoryBot.define do
  factory :job do
    title { Faker::Job.title }
    location { "#{Faker::Address.city}, #{Faker::Address.country}" }
    job_type { 2 }
    company_name { Faker::Company.name }
    start_date { '2020-01-01' }
    end_date { '2024-11-01' }
    activities { Array.new(5, Faker::Quote.famous_last_words) }
    profile
  end
end
