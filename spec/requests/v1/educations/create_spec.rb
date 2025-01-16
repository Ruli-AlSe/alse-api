require 'swagger_helper'

RSpec.describe 'v1/educations', type: :request do
  path '/v1/educations' do
    post('Create education') do
      tags :Educations
      consumes 'application/json'
      parameter name: 'payload', in: :body, description: 'JSON to create education',
                schema: { '$ref' => '#/components/schemas/education' }
      security [Bearer: []]
      response(201, 'Successful') do
        let(:user) { create(:owner) }
        let!(:profile) { create(:profile, profilable: user) }
        let(:user_token) { create(:token, user: user) }
        let(:Authorization) { "Bearer #{user_token.token}" }
        let(:payload) {
          { school_name: Faker::Educator.university,
            career: Faker::Educator.degree,
            start_date: '2015-06-01',
            end_date: '2018-06-01',
            location: Faker::Educator.campus,
            professional_license: 'addddsc-wrr-2443-rfc',
            is_course: true,
            relevant_topics: ['Web development', 'Computer vision'] }
        }

        run_test!
      end

      response(401, 'Not Authorized - token for logged user is missing') do
        let(:user) { create(:owner) }
        let!(:profile) { create(:profile, profilable: user) }
        let(:category) { create(:category, company: user.company) }
        let(:Authorization) { 'Bearer ' }
        let(:payload) {
          { school_name: Faker::Educator.university,
            career: Faker::Educator.degree,
            start_date: '2015-06-01',
            end_date: '2018-06-01',
            location: Faker::Educator.campus,
            professional_license: 'addddsc-wrr-2443-rfc',
            is_course: true,
            relevant_topics: ['Web development', 'Computer vision'] }
        }

        run_test!
      end
    end
  end
end
