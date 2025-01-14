require 'swagger_helper'

RSpec.describe 'v1/posts', type: :request do
  path '/v1/posts' do
    post('Posts create') do
      tags :Posts
      consumes 'application/json'
      parameter name: 'payload', in: :body, description: 'JSON to create the post',
                schema: { '$ref' => '#/components/schemas/post' }
      # security to specify that we need to be logged in to create a post
      security [Bearer: []]
      response(201, 'successful') do
        let(:user) { create(:owner) }
        let(:category) { create(:category) }
        let(:user_token) { create(:token, user: user) }
        # we need to specify the Authorization header with the token
        let(:Authorization) { "Bearer #{user_token.token}" }
        let(:payload) {
          { post: { title: 'test',
                    content: 'test description',
                    credits: 'link.name, company name, user name',
                    image_url: 'image.url',
                    slug: 'test-slug',
                    category_id: category.id } }
        }
        run_test!
      end

      response(401, 'not authorized') do
        let(:Authorization) { 'Bearer' }
        let(:payload) {
          { post: { name: 'test',
                       description: 'test description',
                       price: 50 } }
        }

        run_test!
      end
    end
  end
end
