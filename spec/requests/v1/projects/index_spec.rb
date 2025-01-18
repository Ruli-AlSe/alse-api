require 'swagger_helper'

RSpec.describe 'v1/projects', type: :request do
  path '/v1/projects/{email}' do
    get('Projects list') do
      tags :Projects
      consumes 'application/json'
      parameter name: 'email', in: :path, description: 'Email of the owner of the posts',
                schema: { '$ref' => '#/components/schemas/project_email' }

      response(200, 'Successful') do
        let(:user) { create(:owner) }
        let(:email) { user.email }
        let!(:projects) { create_list(:project, 10, company: user.company) }

        run_test!
      end

      response(404, 'Not found - projects not found with email provided') do
        let(:user) { create(:owner) }
        let(:email) { 'incorrect@email.com' }
        let!(:projects) { create_list(:project, 10, company: user.company) }

        run_test!
      end
    end
  end
end
