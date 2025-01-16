require 'rails_helper'

RSpec.describe V1::EducationsController, type: :controller do
  describe 'Create education' do
    let(:user) { create(:owner) }
    let!(:user_profile) { create(:profile, profilable: user) }
    let(:bearer) { create(:token, user: user) }
    let(:headers) { { 'Authorization': "Bearer #{bearer.token}" } }
    let(:education_info) {
      { school_name: Faker::Educator.university,
        career: Faker::Educator.degree,
        start_date: '2015-06-01',
        end_date: '2018-06-01',
        location: Faker::Educator.campus,
        professional_license: 'addddsc-wrr-2443-rfc',
        is_course: true,
        relevant_topics: ['Web development', 'Computer vision'] }
    }

    context 'Education registered successfully' do
      before do
        request.headers.merge!(headers)
        post(:create, format: :json, params: { education: education_info })
      end

      context 'response with status created' do
        subject { response }
        it { is_expected.to have_http_status(:created) }
      end

      context 'response with correct education structure' do
        subject { payload_test }
        it {
          is_expected.to include(:id, :school_name, :career, :start_date, :end_date, :location,
                                 :professional_license, :is_course, :relevant_topics, :created_at, :updated_at)
        }
        it { expect(subject[:school_name]).to eq(education_info[:school_name]) }
      end
    end

    context 'education not registered' do
      before do
        education_info[:school_name] = ''
        request.headers.merge!(headers)
        post(:create, format: :json, params: { education: education_info })
      end

      context 'response with status bad request' do
        subject { response }
        it { is_expected.to have_http_status(:bad_request) }
      end

      context 'response with correct errors structure' do
        subject { payload_test }
        it { is_expected.to include(:errors) }
      end
    end

    context 'post request without token' do
      before do
        post(:create, format: :json, params: { education: education_info })
      end

      context 'response with status unauthorized' do
        subject { response }
        it { is_expected.to have_http_status(:unauthorized) }
      end
    end
  end
end
