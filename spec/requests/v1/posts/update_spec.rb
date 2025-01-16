require 'swagger_helper'

RSpec.describe 'v1/posts', type: :request do
  path '/v1/posts/{id}' do
    put('Posts update') do
      tags :Posts
      consumes  'application/json'
      parameter name: 'payload', in: :body, description: 'JSON to update the post',
                schema: { '$ref' => '#/components/schemas/post' }
      parameter name: 'id', in: :path, description: 'Post id',
                schema: { '$ref' => '#/components/schemas/post_id' }
      security [Bearer: []]

      response(200, 'successful') do
        let(:user) { create(:owner) }
        let(:post) { create(:post, company: user.company) }
        let(:id) { post.id }
        let(:user_token) { create(:token, user: user) }
        let(:Authorization) { "Bearer #{user_token.token}" }
        let(:payload) {
          { post: { name: 'post updated',
                    description: 'post description updated',
                    price: 1000 } }
        }

        run_test!
      end
    end
  end
end
