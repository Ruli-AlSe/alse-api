require 'swagger_helper'

RSpec.describe 'v1/categories', type: :request do
  path '/v1/categories/{id}' do
    put('Categories update') do
      tags :Categories
      consumes 'application/json'
      parameter name: 'id', in: :path, description: 'Category id',
                schema: { '$ref' => '#/components/schemas/category_id' }
      parameter name: 'payload', in: :body, description: 'JSON to update the category',
                schema: { '$ref' => '#/components/schemas/category' }
      security [Bearer: []]

      response(200, 'Successful') do
        let(:user) { create(:owner_company_categories) }
        let(:id) { user.company.categories.first.id }
        let(:user_token) { create(:token, user: user) }
        let(:Authorization) { "Bearer #{user_token.token}" }
        let(:payload) {
          { category: { title: 'Title updated',
                        description: 'Description updated' } }
        }

        run_test!
      end

      response(401, 'Not Authorized') do
        let(:user) { create(:owner_company_categories) }
        let(:id) { user.company.categories.first.id }
        let(:Authorization) { 'Bearer ' }
        let(:payload) {
          { category: { title: 'Title updated',
                        description: 'Description updated' } }
        }

        run_test!
      end

      response(404, 'Category Not Found') do
        let(:user) { create(:owner_company_categories) }
        let(:id) { 0 }
        let(:user_token) { create(:token, user: user) }
        let(:Authorization) { "Bearer #{user_token.token}" }
        let(:payload) {
          { category: { title: 'Title updated',
                        description: 'Description updated' } }
        }

        run_test!
      end
    end
  end
end
