require 'swagger_helper'

RSpec.describe 'v1/categories', type: :request do
  path '/v1/categories' do
    get('Categories list') do
      tags :Categories
      consumes 'application/json'
      security [Bearer: []]

      response(200, 'Successful') do
        let(:user) { create(:owner_company_categories) }
        let(:user_token) { create(:token, user: user) }
        let(:Authorization) { "Bearer #{user_token.token}" }

        run_test!
      end

      response(401, 'Not Authorized') do
        let(:Authorization) { 'Bearer ' }

        run_test!
      end
    end
  end
end
