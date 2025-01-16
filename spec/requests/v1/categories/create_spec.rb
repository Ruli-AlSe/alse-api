require 'swagger_helper'

RSpec.describe 'v1/categories', type: :request do
  path '/v1/categories' do
    post('Categories create') do
      tags :Categories
      consumes 'application/json'
      parameter name: 'payload', in: :body, description: 'JSON to create the category',
                schema: { '$ref' => '#/components/schemas/category' }
      security [Bearer: []]

      response(201, 'Successful') do
        let(:user) { create(:owner) }
        let(:user_token) { create(:token, user: user) }
        let(:Authorization) { "Bearer #{user_token.token}" }
        let(:payload) {
          { category: { title: 'New category',
                        slug: 'new-category',
                        description: 'New category description' } }
        }

        run_test!
      end

      response(400, 'Bad Request') do
        let(:user) { create(:owner_company_categories) }
        let(:user_token) { create(:token, user: user) }
        let(:Authorization) { "Bearer #{user_token.token}" }
        let(:payload) {
          { category: { title: 'New category',
                        slug: user.company.categories.first.slug,
                        description: 'New category description' } }
        }

        run_test!
      end

      response(401, 'Not Authorized') do
        let(:Authorization) { 'Bearer ' }
        let(:payload) {
          { category: { title: 'New category',
                        slug: 'new-category',
                        description: 'New category description' } }
        }

        run_test!
      end
    end
  end
end
