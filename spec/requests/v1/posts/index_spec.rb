require 'swagger_helper'

RSpec.describe 'v1/posts', type: :request do
  path '/v1/posts/{email}' do
    get('Posts list') do
      tags :Posts
      consumes 'application/json'
      parameter name: 'email', in: :path, description: 'Email of the owner of the posts',
                schema: { '$ref' => '#/components/schemas/post_email' }

      response(200, 'successful') do
        let(:user) { create(:owner) }
        let!(:posts) { create_list(:post, 20, company: user.company) }
        let(:email) { user.email }

        run_test!
      end

      response(404, 'Not found - posts not found with email provided') do
        let(:user) { create(:owner) }
        let!(:posts) { create_list(:post, 20, company: user.company) }
        let(:email) { 'incorrect@email.com' }

        run_test!
      end
    end
  end
end
