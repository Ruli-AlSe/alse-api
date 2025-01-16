require 'rails_helper'

RSpec.describe V1::ProjectsController, type: :controller do
  describe 'Projects listing' do
    let(:user) { create(:owner) }
    let(:bearer) { create(:token, user: user) }
    let(:headers) { { 'Authorization': "Bearer #{bearer.token}" } }

    context 'get all projects correctly' do
      before do
        request.headers.merge! headers
        get(:index, format: :json)
      end

      context 'response with status ok' do
        subject { response }
        it { is_expected.to have_http_status(:ok) }
      end

      context 'correct structure of response' do
        subject { payload_test }
        it { is_expected.to include(:projects) }
      end
    end

    context 'get projects without token' do
      before do
        get(:index, format: :json)
      end

      context 'response with status unauthorized' do
        subject { response }
        it { is_expected.to have_http_status(:unauthorized) }
      end
    end
  end
end
