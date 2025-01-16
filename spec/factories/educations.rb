FactoryBot.define do
  factory :education do
    school_name { Faker::Educator.university }
    career { Faker::Educator.degree }
    start_date { '2025-01-15' }
    end_date { '2025-01-15' }
    location { Faker::Educator.campus }
    professional_license { '' }
    is_course { false }
    relevant_topics { Array.new(3, Faker::Educator.course_name) }
    profile
  end
end
