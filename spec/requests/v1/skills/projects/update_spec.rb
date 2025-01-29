require 'swagger_helper'

RSpec.describe 'v1/projects/{project_id/skills/id', type: :request do
  path '/v1/projects/{project_id}/skills/{id}' do
    put('update Skill for project') do
      tags :Skills
      consumes 'application/json'
      parameter name: 'payload', in: :body, description: 'JSON to update skill',
                schema: { '$ref' => '#/components/schemas/skill' }
      parameter name: 'id', in: :path, description: 'Skill id',
                schema: { '$ref' => '#/components/schemas/skill_id' }
      parameter name: 'project_id', in: :path, description: 'Project id',
                schema: { '$ref' => '#/components/schemas/project_id' }
      security [Bearer: []]
      response(200, 'Successful') do
        let(:user) { create(:owner) }
        let(:project) { create(:project, company: user.company) }
        let(:project_id) { project.id }
        let(:category) { create(:category, company: user.company) }
        let(:skill) { create(:skill, category: category, skillable: project) }
        let(:id) { skill.id }
        let(:user_token) { create(:token, user: user) }
        let(:Authorization) { "Bearer #{user_token.token}" }
        let(:payload) {
          { skill: { name: 'skill name updated',
                     icon_url: 'avatar.com/icons/icon.png',
                     level: 3,
                     category_id: category.id } }
        }
        run_test!
      end

      response(401, 'Not Authorized') do
        let(:user) { create(:owner) }
        let(:project) { create(:project, company: user.company) }
        let(:project_id) { project.id }
        let(:category) { create(:category, company: user.company) }
        let(:skill) { create(:skill, category: category, skillable: project) }
        let(:id) { skill.id }
        let(:Authorization) { 'Bearer ' }
        let(:payload) {
          { skill: { name: 'skill name',
                     icon_url: 'avatar.com/icons/icon.png',
                     level: 3,
                     category_id: category.id } }
        }

        run_test!
      end

      response(404, 'Not Found - project_id or skill_id not found') do
        let(:user) { create(:owner) }
        let(:project) { create(:project, company: user.company) }
        let(:project_id) { project.id }
        let(:category) { create(:category, company: user.company) }
        let(:skill) { create(:skill, category: category, skillable: project) }
        let(:id) { 0 }
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
    end
  end
end
