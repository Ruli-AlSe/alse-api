require 'swagger_helper'

RSpec.describe 'v1/posts', type: :request do
  path '/v1/posts/{id}' do
    delete('Delete a post') do
      tags :Posts
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string, description: 'Post id',
                schema: { '$ref' => '#/components/schemas/post_id' }
      security [Bearer: []]

      response(200, 'successful') do
        let(:user) { create(:owner) }
        let(:post) { create(:post, company: user.company) }
        let(:id) { post.id }
        let(:user_token) { create(:token, user: user) }
        let(:Authorization) { "Bearer #{user_token.token}" }

        run_test!
      end
    end
  end
end
