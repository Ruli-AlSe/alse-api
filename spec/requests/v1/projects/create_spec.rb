require 'swagger_helper'

RSpec.describe 'v1/projects', type: :request do
  path '/v1/projects' do
    post('Create project') do
      tags :Projects
      consumes 'application/json'
      parameter name: 'payload', in: :body, description: 'JSON to create project',
                schema: { '$ref' => '#/components/schemas/project' }
      security [Bearer: []]
      response(201, 'Successful') do
        let(:user) { create(:owner) }
        let(:user_token) { create(:token, user: user) }
        let(:Authorization) { "Bearer #{user_token.token}" }
        let(:payload) {
          { name: Faker::App.name,
            description: Faker::Lorem.sentence,
            company_name: Faker::Company.name,
            live_url: Faker::Internet.url,
            repository_url: Faker::Internet.url }
        }

        run_test!
      end

      response(401, 'Not Authorized - token for logged user is missing') do
        let(:user) { create(:owner) }
        let(:Authorization) { 'Bearer invalid-token' }
        let(:payload) {
          { name: Faker::App.name,
            description: Faker::Lorem.sentence,
            company_name: Faker::Company.name,
            live_url: Faker::Internet.url,
            repository_url: Faker::Internet.url }
        }

        run_test!
      end
    end
  end
end
