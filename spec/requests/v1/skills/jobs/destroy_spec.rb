require 'swagger_helper'

RSpec.describe 'v1/jobs/job_id/skills/id', type: :request do
  path '/v1/jobs/{job_id}/skills/{id}' do
    delete('Delete skill for job') do
      tags :Skills
      consumes 'application/json'
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
        let(:skill) { create(:skill, category: category, skillable: job) }
        let(:job_id) { job.id }
        let(:id) { skill.id }
        let(:user_token) { create(:token, user: user) }
        let(:Authorization) { "Bearer #{user_token.token}" }

        run_test!
      end

      response(401, 'Not Authorized') do
        let(:user) { create(:owner) }
        let!(:profile) { create(:profile, profilable: user) }
        let(:category) { create(:category, company: user.company) }
        let(:job) { create(:job, profile: profile) }
        let(:job_id) { job.id }
        let(:skill) { create(:skill, category: category, skillable: profile) }
        let(:id) { skill.id }
        let(:Authorization) { 'Bearer ' }

        run_test!
      end

      response(404, 'Not Found - job_id or skill_id not found') do
        let(:user) { create(:owner) }
        let!(:profile) { create(:profile, profilable: user) }
        let(:category) { create(:category, company: user.company) }
        let(:skill) { create(:skill, category: category, skillable: profile) }
        let(:job) { create(:job, profile: profile) }
        let(:job_id) { job.id }
        let(:id) { 0 }
        let(:user_token) { create(:token, user: user) }
        let(:Authorization) { "Bearer #{user_token.token}" }

        run_test!
      end
    end
  end
end
