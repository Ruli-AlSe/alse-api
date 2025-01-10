require 'swagger_helper'

RSpec.describe 'v1/products', type: :request do
  path '/v1/products' do
    post('Products create') do
      tags :Products
      consumes 'application/json'
      parameter name: 'payload', in: :body, description: 'JSON to create the product',
                schema: { '$ref' => '#/components/schemas/product' }
      # security to specify that we need to be logged in to create a product
      security [Bearer: []]
      response(201, 'successful') do
        let(:user) { create(:owner) }
        let(:user_token) { create(:token, user: user) }
        # we need to specify the Authorization header with the token
        let(:Authorization) { "Bearer #{user_token.token}" }
        let(:payload) {
          { product: { name: 'test',
                       description: 'test description',
                       price: 50 } }
        }
        run_test!
      end

      response(401, 'not authorized') do
        let(:Authorization) { 'Bearer' }
        let(:payload) {
          { product: { name: 'test',
                       description: 'test description',
                       price: 50 } }
        }

        run_test!
      end
    end
  end
end
