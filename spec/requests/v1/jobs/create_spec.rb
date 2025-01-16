require 'swagger_helper'

RSpec.describe 'v1/jobs', type: :request do
  path '/v1/jobs' do
    post('Create job') do
      tags :Jobs
      consumes 'application/json'
      parameter name: 'payload', in: :body, description: 'JSON to create job',
                schema: { '$ref' => '#/components/schemas/job' }
      security [Bearer: []]
      response(201, 'Successful') do
        let(:user) { create(:owner) }
        let!(:profile) { create(:profile, profilable: user) }
        let(:user_token) { create(:token, user: user) }
        let(:Authorization) { "Bearer #{user_token.token}" }
        let(:payload) {
          { title: Faker::Job.title,
            location: "#{Faker::Address.city}, #{Faker::Address.country}",
            job_type: 2,
            company_name: Faker::Company.name,
            start_date: '2020-11-01',
            end_date: '2024-06-01',
            activities: Array.new(5, Faker::Quote.famous_last_words) }
        }

        run_test!
      end

      response(401, 'Not Authorized - token for logged user is missing') do
        let(:user) { create(:owner) }
        let!(:profile) { create(:profile, profilable: user) }
        let(:Authorization) { 'Bearer invalid-token' }
        let(:payload) {
          { title: Faker::Job.title,
            location: "#{Faker::Address.city}, #{Faker::Address.country}",
            job_type: 2,
            company_name: Faker::Company.name,
            start_date: '2020-11-01',
            end_date: '2024-06-01',
            activities: Array.new(5, Faker::Quote.famous_last_words) }
        }

        run_test!
      end
    end
  end
end
