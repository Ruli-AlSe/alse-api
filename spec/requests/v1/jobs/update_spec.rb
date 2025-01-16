require 'swagger_helper'

RSpec.describe 'v1/jobs', type: :request do
  path '/v1/jobs/{id}' do
    put('Update job') do
      tags :Jobs
      consumes 'application/json'
      parameter name: 'payload', in: :body, description: 'JSON to create job',
                schema: { '$ref' => '#/components/schemas/job' }
      parameter name: 'id', in: :path, description: 'Job id',
                schema: { '$ref' => '#/components/schemas/job_id' }
      security [Bearer: []]
      response(200, 'Successful') do
        let(:user) { create(:owner) }
        let(:profile) { create(:profile, profilable: user) }
        let(:job) { create(:job, profile: profile) }
        let(:id) { job.id }
        let(:user_token) { create(:token, user: user) }
        let(:Authorization) { "Bearer #{user_token.token}" }
        let(:payload) {
          { title: 'Job title updated',
            start_date: '2022-12-01',
            end_date: '2024-05-31',
            activities: ['Activity updated'] }
        }

        run_test!
      end

      response(401, 'Not Authorized - token for logged user is missing') do
        let(:user) { create(:owner) }
        let!(:profile) { create(:profile, profilable: user) }
        let(:Authorization) { 'Bearer invalid-token' }
        let(:job) { create(:job, profile: profile) }
        let(:id) { job.id }
        let(:payload) {
          { title: 'Job title updated',
            start_date: '2022-12-01',
            end_date: '2024-05-31',
            activities: ['Activity updated'] }
        }

        run_test!
      end

      response(404, 'Not found - incorrect education id') do
        let(:user) { create(:owner) }
        let(:profile) { create(:profile, profilable: user) }
        let!(:job) { create(:job, profile: profile) }
        let(:id) { 0 }
        let(:user_token) { create(:token, user: user) }
        let(:Authorization) { "Bearer #{user_token.token}" }
        let(:payload) {
          { title: 'Job title updated',
            start_date: '2022-12-01',
            end_date: '2024-05-31',
            activities: ['Activity updated'] }
        }

        run_test!
      end
    end
  end
end
