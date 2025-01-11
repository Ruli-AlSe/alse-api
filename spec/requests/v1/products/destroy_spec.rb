require 'swagger_helper'

RSpec.describe 'v1/products', type: :request do
  path '/v1/products/{id}' do
    delete('Delete a product') do
      tags :Products
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string, description: 'Product id',
                schema: { '$ref' => '#/components/schemas/product_id' }
      security [Bearer: []]

      response(200, 'successful') do
        let(:user) { create(:owner) }
        let(:product) { create(:product, company: user.company) }
        let(:id) { product.id }
        let(:user_token) { create(:token, user: user) }
        let(:Authorization) { "Bearer #{user_token.token}" }

        run_test!
      end
    end
  end
end
