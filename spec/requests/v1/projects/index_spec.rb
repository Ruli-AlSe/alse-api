require 'swagger_helper'

RSpec.describe 'v1/projects', type: :request do
  path '/v1/projects' do
    get('Projects list') do
      tags :Projects
      consumes 'application/json'
      security [Bearer: []]

      response(200, 'Successful') do
        let(:user) { create(:owner) }
        let(:projects) { create_list(:Project, 10, company: user.company) }
        let(:user_token) { create(:token, user: user) }
        let(:Authorization) { "Bearer #{user_token.token}" }

        run_test!
      end

      response(401, 'Not Authorized - token for logged user is missing') do
        let(:user) { create(:owner) }
        let(:projects) { create_list(:Project, 10, company: user.company) }
        let(:Authorization) { 'Bearer invalid-token' }

        run_test!
      end
    end
  end
end
