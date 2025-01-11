require 'swagger_helper'

RSpec.describe 'v1/products', type: :request do
  path '/v1/products/{id}' do
    put('Products update') do
      tags :Products
      consumes  'application/json'
      parameter name: 'payload', in: :body, description: 'JSON to update the product',
                schema: { '$ref' => '#/components/schemas/product' }
      parameter name: 'id', in: :path, description: 'Product id',
                schema: { '$ref' => '#/components/schemas/product_id' }
      security [Bearer: []]

      response(200, 'successful') do
        let(:user) { create(:owner) }
        let(:product) { create(:product, company: user.company) }
        let(:id) { product.id }
        let(:user_token) { create(:token, user: user) }
        let(:Authorization) { "Bearer #{user_token.token}" }
        let(:payload) {
          { product: { name: 'product updated',
                       description: 'product description updated',
                       price: 1000 } }
        }

        run_test!
      end
    end
  end
end
