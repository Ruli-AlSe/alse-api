require 'swagger_helper'

RSpec.describe 'v1/users', type: :request do

  path '/v1/users' do
    post('Users register') do
      # tag to display in swagger
      tags :Users
      # sentence to specify we are using json
      consumes 'application/json'
      # direction to specify we are sending the payload in the body
      parameter name: 'payload', in: :body, description: 'JSON to create the user',
                schema: { '$ref' => '#/components/schemas/user' }

      response(201, 'successful') do
        let(:payload) {
          { user: { email: 'test@example.com',
                    password: '12345678',
                    age: 31,
                    company_attributes: { name: 'test' } } }
        }

        run_test!
      end
    end
  end

  path '/{locale}/v1/users/login' do
    parameter name: 'locale', in: :path, type: :string, description: 'locale'

    post('Users login') do
      tags :Users
      consumes 'application/json'
      parameter name: 'payload', in: :body, description: 'JSON to login',
                schema: { '$ref' => '#/components/schemas/login_user' }

      response(200, 'successful') do
        let(:locale) { 'es' }
        let(:user) { create(:owner, password: '12345678') }
        let(:payload) {
          { user: { email: user.email,
                    password: '12345678' } }
        }

        run_test!
      end
    end
  end
end
