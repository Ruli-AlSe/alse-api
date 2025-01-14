require 'swagger_helper'

RSpec.describe 'v1/profiles', type: :request do
  path '/v1/profiles/{id}' do
    get('Profiles show') do
      tags :Profiles
      consumes  'application/json'
      parameter name: 'id', in: :path, description: 'profile id',
                schema: { '$ref' => '#/components/schemas/profile_id' }
      security [Bearer: []]

      response(200, 'successful') do
        let(:user) { create(:owner) }
        let(:user_profile) { create(:profile, profilable: user) }
        let(:id) { user_profile.id }
        let(:user_token) { create(:token, user: user) }
        let(:Authorization) { "Bearer #{user_token.token}" }

        run_test!
      end
    end
  end
end
