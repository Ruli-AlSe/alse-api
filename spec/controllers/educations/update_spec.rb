require 'rails_helper'

RSpec.describe V1::EducationsController, type: :controller do
  describe 'Update education' do
    let(:user) { create(:owner) }
    let!(:user_profile) { create(:profile, profilable: user) }
    let!(:education) { create(:education, profile: user_profile) }
    let(:bearer) { create(:token, user: user) }
    let(:headers) { { 'Authorization': "Bearer #{bearer.token}" } }
    let(:education_info) {
      { school_name: 'University name updated',
        career: 'Career updated',
        relevant_topics: ['Web development', 'Computer vision'] }
    }

    context 'successful response' do
      before do
        request.headers.merge!(headers)
        put(:update, format: :json, params: { id: education.id, education: education_info })
      end

      context 'with status ok' do
        subject { response }
        it { is_expected.to have_http_status(:ok) }
      end

      context 'with correct education structure' do
        subject { payload_test }
        it {
          is_expected.to include(:id, :school_name, :career, :start_date, :end_date, :location,
                                 :professional_license, :is_course, :relevant_topics, :created_at, :updated_at)
        }
        it { expect(subject[:school_name]).to eq(education_info[:school_name]) }
      end
    end

    context 'unsuccessful response' do
      before do
        education_info[:school_name] = ''
        request.headers.merge!(headers)
        put(:update, format: :json, params: { id: education.id, education: education_info })
      end

      context 'with status bad_request' do
        subject { response }
        it { is_expected.to have_http_status(:bad_request) }
      end

      context 'with correct errors structure' do
        subject { payload_test }
        it { is_expected.to include(:errors) }
      end
    end

    context 'unsuccessful response due to incorrect education id' do
      before do
        request.headers.merge!(headers)
        put(:update, format: :json, params: { id: 0, education: education_info })
      end

      context 'with status not_found' do
        subject { response }
        it { is_expected.to have_http_status(:not_found) }
      end
    end

    context 'send request without token' do
      before do
        put(:update, format: :json, params: { id: education.id, education: education_info })
      end

      context 'with status unauthorized' do
        subject { response }
        it { is_expected.to have_http_status(:unauthorized) }
      end
    end
  end
end
