require 'swagger_helper'

RSpec.describe 'v1/educations', type: :request do
  path '/v1/educations/{id}' do
    put('Education update') do
      tags :Educations
      consumes 'application/json'
      parameter name: 'payload', in: :body, description: 'JSON to update education',
                schema: { '$ref' => '#/components/schemas/education' }
      parameter name: 'id', in: :path, description: 'Education id',
                schema: { '$ref' => '#/components/schemas/education_id' }
      security [Bearer: []]

      response(200, 'Successful') do
        let(:user) { create(:owner) }
        let(:profile) { create(:profile, profilable: user) }
        let(:education) { create(:education, profile: profile) }
        let(:id) { education.id }
        let(:user_token) { create(:token, user: user) }
        let(:Authorization) { "Bearer #{user_token.token}" }
        let(:payload) {
          { school_name: 'New school updated',
            career: 'New career updated',
            relevant_topics: ['Web development'] }
        }

        run_test!
      end

      response(401, 'Not Authorized - token for logged user is missing') do
        let(:user) { create(:owner) }
        let(:profile) { create(:profile, profilable: user) }
        let(:education) { create(:education, profile: profile) }
        let(:id) { education.id }
        let(:user_token) { create(:token, user: user) }
        let(:Authorization) { 'Bearer false-token' }
        let(:payload) {
          { school_name: 'New school updated',
            career: 'New career updated',
            relevant_topics: ['Web development'] }
        }

        run_test!
      end

      response(404, 'Not found - incorrect education id') do
        let(:user) { create(:owner) }
        let(:profile) { create(:profile, profilable: user) }
        let!(:education) { create(:education, profile: profile) }
        let(:id) { 0 }
        let(:user_token) { create(:token, user: user) }
        let(:Authorization) { "Bearer #{user_token.token}" }
        let(:payload) {
          { school_name: 'New school updated',
            career: 'New career updated',
            relevant_topics: ['Web development'] }
        }

        run_test!
      end
    end
  end
end