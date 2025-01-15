require 'swagger_helper'

RSpec.describe 'v1/skills', type: :request do
  path '/v1/skills/{id}' do
    delete('Destroy skill') do
      tags :Skills
      consumes 'application/json'
      parameter name: 'id', in: :path, description: 'Skill id',
                schema: { '$ref' => '#/components/schemas/skill_id' }
      security [Bearer: []]
      response(200, 'Successful') do
        let(:user) { create(:owner) }
        let(:profile) { create(:profile, profilable: user) }
        let(:category) { create(:category, company: user.company) }
        let(:skill) { create(:skill, category: category, profile: profile) }
        let(:id) { skill.id }
        let(:user_token) { create(:token, user: user) }
        let(:Authorization) { "Bearer #{user_token.token}" }

        run_test!
      end

      response(401, 'Not Authorized') do
        let(:user) { create(:owner) }
        let!(:profile) { create(:profile, profilable: user) }
        let(:category) { create(:category, company: user.company) }
        let(:skill) { create(:skill, category: category, profile: profile) }
        let(:id) { skill.id }
        let(:Authorization) { 'Bearer ' }

        run_test!
      end

      response(404, 'Not Found') do
        let(:user) { create(:owner) }
        let!(:profile) { create(:profile, profilable: user) }
        let(:category) { create(:category, company: user.company) }
        let(:skill) { create(:skill, category: category, profile: profile) }
        let(:id) { 0 }
        let(:user_token) { create(:token, user: user) }
        let(:Authorization) { "Bearer #{user_token.token}" }

        run_test!
      end
    end
  end
end
