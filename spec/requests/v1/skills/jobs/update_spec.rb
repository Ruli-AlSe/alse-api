require 'swagger_helper'

RSpec.describe 'v1/jobs/job_id/skills/id', type: :request do
  path '/v1/jobs/{job_id}/skills/{id}' do
    put('Skill update') do
      tags :Skills
      consumes 'application/json'
      parameter name: 'payload', in: :body, description: 'JSON to update skill',
                schema: { '$ref' => '#/components/schemas/skill' }
      parameter name: 'id', in: :path, description: 'Skill id',
                schema: { '$ref' => '#/components/schemas/skill_id' }
      parameter name: 'job_id', in: :path, description: 'Job id',
                schema: { '$ref' => '#/components/schemas/job_id' }
      security [Bearer: []]
      response(200, 'Successful') do
        let(:user) { create(:owner) }
        let(:profile) { create(:profile, profilable: user) }
        let(:category) { create(:category, company: user.company) }
        let(:job) { create(:job, profile: profile) }
        let(:job_id) { job.id }
        let(:skill) { create(:skill, category: category, skillable: job) }
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
        let!(:profile) { create(:profile, profilable: user) }
        let(:category) { create(:category, company: user.company) }
        let(:job) { create(:job, profile: profile) }
        let(:job_id) { job.id }
        let(:skill) { create(:skill, category: category, skillable: job) }
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

      response(404, 'Not Found - job_id or skill_id not found') do
        let(:user) { create(:owner) }
        let!(:profile) { create(:profile, profilable: user) }
        let(:category) { create(:category, company: user.company) }
        let(:job) { create(:job, profile: profile) }
        let(:job_id) { job.id }
        let(:skill) { create(:skill, category: category, skillable: job) }
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
