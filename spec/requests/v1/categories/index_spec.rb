require 'swagger_helper'

RSpec.describe 'v1/categories', type: :request do
  path '/v1/categories/{email}' do
    get('Categories list') do
      tags :Categories
      consumes 'application/json'
      parameter name: 'email', in: :path, description: 'Email of the owner of the categories',
                schema: { '$ref' => '#/components/schemas/category_email' }

      response(200, 'Successful') do
        let(:user) { create(:owner_company_categories) }
        let(:email) { user.email }

        run_test!
      end

      response(404, 'Not found - categories not found with email provided') do
        let(:user) { create(:owner_company_categories) }
        let(:email) { 'incorrect@email.com' }

        run_test!
      end
    end
  end
end
