require 'swagger_helper'

RSpec.describe 'v1/profiles/profile_id/skills', type: :request do
  path '/v1/profiles/{profile_id}/skills' do
    post('create Skill for profile') do
      tags :Skills
      consumes 'application/json'
      parameter name: 'profile_id', in: :path, description: 'Profile id',
                schema: { '$ref' => '#/components/schemas/profile_id' }
      parameter name: 'payload', in: :body, description: 'JSON to create skill',
                schema: { '$ref' => '#/components/schemas/skill' }
      security [Bearer: []]
      response(201, 'Successful') do
        let(:user) { create(:owner) }
        let(:profile) { create(:profile, profilable: user) }
        let(:profile_id) { profile.id }
        let(:category) { create(:category, company: user.company) }
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
        let!(:profile) { create(:profile, profilable: user) }
        let(:category) { create(:category, company: user.company) }
        let(:profile_id) { profile.id }
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
