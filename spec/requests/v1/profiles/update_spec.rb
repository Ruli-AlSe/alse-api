require 'swagger_helper'

RSpec.describe 'v1/profiles', type: :request do
  path '/v1/profiles/{id}' do
    put('Profiles update') do
      tags :Profiles
      consumes  'application/json'
      parameter name: 'payload', in: :body, description: 'JSON to update the profile',
                schema: { '$ref' => '#/components/schemas/profile' }
      parameter name: 'id', in: :path, description: 'profile id',
                schema: { '$ref' => '#/components/schemas/profile_id' }
      security [Bearer: []]

      response(200, 'successful') do
        let(:user) { create(:owner) }
        let(:user_profile) { create(:profile, profilable: user) }
        let(:id) { user_profile.id }
        let(:user_token) { create(:token, user: user) }
        let(:Authorization) { "Bearer #{user_token.token}" }
        let(:payload) {
          { profile: { name: 'User name',
                       last_name: 'User last_name',
                       headliner: 'User headliner',
                       bio: 'User bio',
                       city: 'User city',
                       state: 'User state',
                       country: 'User country',
                       phone_number: '437799004388',
                       social_media: 'linkedin.com,facebook.com,instagram.com,github.com,whatsapp.com,x.com' } }
        }

        run_test!
      end
    end
  end
end
