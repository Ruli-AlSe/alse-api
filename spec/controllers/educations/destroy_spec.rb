require 'rails_helper'

RSpec.describe V1::EducationsController, type: :controller do
  describe 'Destroy education' do
    let(:user) { create(:owner) }
    let!(:user_profile) { create(:profile, profilable: user) }
    let!(:education) { create(:education, profile: user_profile) }
    let(:bearer) { create(:token, user: user) }
    let(:headers) { { 'Authorization': "Bearer #{bearer.token}" } }

    context 'successful response' do
      before do
        request.headers.merge!(headers)
        delete(:destroy, format: :json, params: { id: education.id })
      end

      context 'with status ok' do
        subject { response }
        it { is_expected.to have_http_status(:ok) }
      end
    end

    context 'unsuccessful response' do
      before do
        request.headers.merge!(headers)
        delete(:destroy, format: :json, params: { id: 0 })
      end

      context 'with status not_found' do
        subject { response }
        it { is_expected.to have_http_status(:not_found) }
      end
    end

    context 'send request without token' do
      before do
        delete(:destroy, format: :json, params: { id: education.id })
      end

      context 'with status unauthorized' do
        subject { response }
        it { is_expected.to have_http_status(:unauthorized) }
      end
    end
  end
end
