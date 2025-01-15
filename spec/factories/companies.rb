FactoryBot.define do
  factory :company do
    name { Faker::Company.name }

    # company_with_categories will create post data after the company has been created
    factory :company_with_categories do
      # categories_count is declared as a transient attribute available in the
      # callback via the evaluator
      transient do
        categories_count { 3 }
      end

      after(:create) do |company, evaluator|
        create_list(:category, evaluator.categories_count, company: company)
        company.reload
      end
    end
  end
end
