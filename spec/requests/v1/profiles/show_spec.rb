require 'swagger_helper'

RSpec.describe 'v1/profiles', type: :request do
  path '/v1/profiles/{email}' do
    get('Profiles show') do
      tags :Profiles
      consumes  'application/json'
      parameter name: 'email', in: :path, description: 'Profile email',
                schema: { '$ref' => '#/components/schemas/profile_email' }

      response(200, 'Successful') do
        let(:user) { create(:owner) }
        let!(:user_profile) { create(:profile, profilable: user) }
        let(:email) { user.email }

        run_test!
      end

      response(404, 'Not found - User profile not found with email provided') do
        let(:user) { create(:owner) }
        let!(:user_profile) { create(:profile, profilable: user) }
        let(:email) { 'incorrect@email.com' }

        run_test!
      end
    end
  end
end
