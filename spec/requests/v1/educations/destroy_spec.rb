require 'swagger_helper'

RSpec.describe 'v1/educations', type: :request do
  path '/v1/educations/{id}' do
    delete('Destroy education') do
      tags :Educations
      consumes 'application/json'
      parameter name: 'id', in: :path, description: 'Education id',
                schema: { '$ref' => '#/components/schemas/skill_id' }
      security [Bearer: []]
      response(200, 'Successful') do
        let(:user) { create(:owner) }
        let(:profile) { create(:profile, profilable: user) }
        let(:education) { create(:education, profile: profile) }
        let(:id) { education.id }
        let(:user_token) { create(:token, user: user) }
        let(:Authorization) { "Bearer #{user_token.token}" }

        run_test!
      end

      response(401, 'Not Authorized - token for logged user is missing') do
        let(:user) { create(:owner) }
        let(:profile) { create(:profile, profilable: user) }
        let(:education) { create(:education, profile: profile) }
        let(:id) { education.id }
        let(:Authorization) { 'Bearer incorrect-token' }

        run_test!
      end

      response(404, 'Not found - incorrect education id') do
        let(:user) { create(:owner) }
        let(:profile) { create(:profile, profilable: user) }
        let!(:education) { create(:education, profile: profile) }
        let(:id) { 0 }
        let(:user_token) { create(:token, user: user) }
        let(:Authorization) { "Bearer #{user_token.token}" }

        run_test!
      end
    end
  end
end
