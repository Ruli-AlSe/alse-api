require 'swagger_helper'

RSpec.describe 'v1/posts', type: :request do
  path '/v1/posts' do
    get('Posts list') do
      tags :Posts
      consumes 'application/json'
      security [Bearer: []]

      response(200, 'successful') do
        let(:user) { create(:owner) }
        let(:posts) { create_list(:post, 20, company: user.company) }
        let(:user_token) { create(:token, user: user) }
        let(:Authorization) { "Bearer #{user_token.token}" }

        run_test!
      end
    end
  end
end
