require 'swagger_helper'

RSpec.describe 'v1/projects', type: :request do
  path '/v1/projects/{id}' do
    delete('Destroy project') do
      tags :Projects
      consumes 'application/json'
      parameter name: 'id', in: :path, description: 'Project id',
                schema: { '$ref' => '#/components/schemas/project_id' }
      security [Bearer: []]

      response(200, 'Successful') do
        let(:user) { create(:owner) }
        let(:project) { create(:project, company: user.company) }
        let(:id) { project.id }
        let(:user_token) { create(:token, user: user) }
        let(:Authorization) { "Bearer #{user_token.token}" }

        run_test!
      end

      response(401, 'Not Authorized - token for logged user is missing') do
        let(:user) { create(:owner) }
        let(:project) { create(:project, company: user.company) }
        let(:Authorization) { 'Bearer invalid-token' }
        let(:id) { project.id }

        run_test!
      end

      response(404, 'Not found - incorrect project id') do
        let(:user) { create(:owner) }
        let(:project) { create(:project, company: user.company) }
        let(:user_token) { create(:token, user: user) }
        let(:Authorization) { "Bearer #{user_token.token}" }
        let(:id) { 0 }

        run_test!
      end
    end
  end
end
