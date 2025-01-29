require 'swagger_helper'

RSpec.describe 'v1/projects/project_id/skills', type: :request do
  path '/v1/projects/{project_id}/skills' do
    post('Skill create') do
      tags :Skills
      consumes 'application/json'
      parameter name: 'project_id', in: :path, description: 'Project id',
                schema: { '$ref' => '#/components/schemas/project_id' }
      parameter name: 'payload', in: :body, description: 'JSON to create skill',
                schema: { '$ref' => '#/components/schemas/skill' }
      security [Bearer: []]
      response(201, 'Successful') do
        let(:user) { create(:owner) }
        let(:category) { create(:category, company: user.company) }
        let(:project) { create(:project, company: user.company) }
        let(:project_id) { project.id }
        let(:user_token) { create(:token, user: user) }
        let(:Authorization) { "Bearer #{user_token.token}" }
        let(:payload) {
          { skill: { name: 'skill name',
                     icon_url: 'avatar.com/icons/icon.png',
                     level: 3,
                     category_id: category.id } }
        }
        run_test!
      end

      response(401, 'Not Authorized') do
        let(:user) { create(:owner) }
        let(:category) { create(:category, company: user.company) }
        let(:project) { create(:project, company: user.company) }
        let(:project_id) { project.id }
        let(:Authorization) { 'Bearer ' }
        let(:payload) {
          { skill: { name: 'skill name',
                     icon_url: 'avatar.com/icons/icon.png',
                     level: 3,
                     category_id: category.id } }
        }

        run_test!
      end
    end
  end
end
